// SPDX-License-Identifier: Apache-2.0

import GRPC
import Hiero
import HieroExampleUtilities
import XCTest

internal class TopicMessage: XCTestCase {
    internal func testBasic() async throws {
        let testEnv = try TestEnvironment.nonFree

        let topic = try await Topic.create(testEnv)

        addTeardownBlock {
            try await topic.delete(testEnv)
        }

        async let submitFut = TopicMessageSubmitTransaction()
            .topicId(topic.id)
            .message("Hello, from HCS!".data(using: .utf8)!)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        async let messages = withThrowingTaskGroup(of: [Hiero.TopicMessage].self) { group in
            group.addTask {
                for _ in 0..<20 {
                    do {
                        return try await TopicMessageQuery(
                            topicId: topic.id,
                            startTime: .init(fromUnixTimestampNanos: 0),
                            limit: 1
                        )
                        .execute(testEnv.client)
                    } catch let error as HError {
                        // topic not found -> try again
                        switch error.kind {
                        case .grpcStatus(let status) where status == GRPCStatus.Code.notFound.rawValue:
                            try await Task.sleep(nanoseconds: 200 * 1_000_000)
                            continue

                        default: throw error
                        }
                    }
                }

                XCTFail("Couldn't get topic after 20 attempts")
                throw CancellationError()
            }
            group.addTask {
                await Task.yield()
                try await Task.sleep(nanoseconds: 60 * 1_000_000_000)
                XCTFail("Operation timed out")
                throw CancellationError()
            }

            defer { group.cancelAll() }
            return try await group.next()!
        }

        do {
            let (messages, _) = try await (messages, submitFut)

            XCTAssertEqual(messages.count, 1)
            XCTAssertEqual(messages[0].contents, "Hello, from HCS!".data(using: .utf8)!)
        }
    }

    internal func testLarge() async throws {
        let testEnv = try TestEnvironment.nonFree
        async let bigContentsFut = Resources.bigContents.data(using: .utf8)!

        let topic = try await Topic.create(testEnv)

        addTeardownBlock {
            try await topic.delete(testEnv)
        }

        let bigContents = try await bigContentsFut

        async let submitFut = TopicMessageSubmitTransaction()
            .message(bigContents)
            .topicId(topic.id)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        async let messages = withThrowingTaskGroup(of: [Hiero.TopicMessage].self) { group in
            group.addTask {
                for _ in 0..<20 {
                    do {
                        return try await TopicMessageQuery(
                            topicId: topic.id,
                            startTime: .init(fromUnixTimestampNanos: 0),
                            limit: 14
                        )
                        .execute(testEnv.client)
                    } catch let error as HError {
                        // topic not found -> try again
                        switch error.kind {
                        case .grpcStatus(let status) where status == GRPCStatus.Code.notFound.rawValue:
                            try await Task.sleep(nanoseconds: 200 * 1_000_000)
                            continue

                        default: throw error
                        }
                    }
                }

                XCTFail("Couldn't get topic after 20 attempts")
                throw CancellationError()
            }

            group.addTask {
                await Task.yield()
                try await Task.sleep(nanoseconds: 60 * 1_000_000_000)
                throw CancellationError()
            }

            defer { group.cancelAll() }
            return try await group.next()!
        }

        do {
            let (messages, _) = try await (messages, submitFut)

            XCTAssertEqual(messages.count, 1)
            XCTAssertEqual(messages[0].contents, bigContents)
        }
    }
}

// SPDX-License-Identifier: Apache-2.0

import Foundation
import GRPC
import HieroProtobufs

/// Submit a message for consensus.
///
/// Valid and authorized messages on valid topics will be ordered by the consensus service, gossipped to the
/// mirror net, and published (in order) to all subscribers (from the mirror net) on this topic.
///
/// The `submitKey` (if any) must sign this transaction.
///
/// On success, the resulting `TransactionReceipt` contains the topic's updated `topicSequenceNumber` and
/// `topicRunningHash`.
public final class TopicMessageSubmitTransaction: ChunkedTransaction {
    /// Create a new `TopicMessageSubmitTransaction` ready for configuration.
    public override init() {
        super.init()
    }

    internal init(protobuf proto: Proto_TransactionBody, _ data: [Proto_ConsensusSubmitMessageTransactionBody]) throws {
        var iter = data.makeIterator()
        let first = iter.next()!

        self.topicId = first.hasTopicID ? .fromProtobuf(first.topicID) : nil
        let chunks = data.count
        var message: Data = first.message
        var largestChunkSize = max(first.message.count, 1)

        // note: no other SDK checks for correctness here... so let's not do it here either?
        for item in iter {
            largestChunkSize = max(largestChunkSize, item.message.count)
            message.append(item.message)
        }

        try super.init(protobuf: proto, data: message, chunks: chunks, largestChunkSize: largestChunkSize)
    }

    /// The topic ID to submit this message to.
    public var topicId: TopicId? {
        willSet {
            ensureNotFrozen()
        }
    }

    /// Sets the topic ID to submit this message to.
    @discardableResult
    public func topicId(_ topicId: TopicId) -> Self {
        self.topicId = topicId

        return self
    }

    /// Message to be submitted.
    /// Max size of the Transaction (including signatures) is 6KiB before chunking.
    public var message: Data {
        get { data }
        set(message) {
            ensureNotFrozen()
            data = message
        }
    }

    /// Sets the message to be submitted.
    @discardableResult
    public func message(_ message: Data) -> Self {
        self.message = message

        return self
    }

    /// Sets the custom fees that will be applied to the transaction.
    @discardableResult
    public override func customFeeLimits(_ customFeeLimits: [CustomFeeLimit]) -> Self {
        self.customFeeLimits = customFeeLimits

        return self
    }

    /// Adds a custom fee limit to the list of custom fee limits.
    @discardableResult
    public override func addCustomFeeLimit(_ customFeeLimit: CustomFeeLimit) -> Self {
        customFeeLimits.append(customFeeLimit)

        return self
    }

    /// Clears the custom fee limit for the topic.
    @discardableResult
    public override func clearCustomFeeLimits() -> Self {
        self.customFeeLimits = []
        return self
    }

    internal override func validateChecksums(on ledgerId: LedgerId) throws {
        try topicId?.validateChecksums(on: ledgerId)
        try super.validateChecksums(on: ledgerId)
    }

    internal override func transactionExecute(_ channel: GRPCChannel, _ request: Proto_Transaction) async throws
        -> Proto_TransactionResponse
    {
        try await Proto_ConsensusServiceAsyncClient(channel: channel).submitMessage(
            request, callOptions: applyGrpcHeader())
    }

    internal override func toTransactionDataProtobuf(_ chunkInfo: ChunkInfo) -> Proto_TransactionBody.OneOf_Data {
        .consensusSubmitMessage(
            .with { proto in
                self.topicId?.toProtobufInto(&proto.topicID)
                proto.message = self.messageChunk(chunkInfo)
                if chunkInfo.total > 1 {
                    proto.chunkInfo = .with { protoChunkInfo in
                        protoChunkInfo.initialTransactionID = chunkInfo.initialTransactionId.toProtobuf()
                        protoChunkInfo.number = Int32(chunkInfo.current + 1)
                        protoChunkInfo.total = Int32(chunkInfo.total)
                    }
                }
            })
    }
}

extension TopicMessageSubmitTransaction {
    internal func toSchedulableTransactionData() -> Proto_SchedulableTransactionBody.OneOf_Data {
        precondition(usedChunks == 1)

        return .consensusSubmitMessage(
            .with { proto in
                topicId?.toProtobufInto(&proto.topicID)
                proto.message = self.message
            }
        )
    }
}

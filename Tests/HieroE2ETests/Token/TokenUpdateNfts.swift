// SPDX-License-Identifier: Apache-2.0

import Hiero
import XCTest

internal final class TokenUpdateNfts: XCTestCase {
    internal func testUpdateNftMetadata() async throws {
        let testEnv = try TestEnvironment.nonFree

        let metadataKey = PrivateKey.generateEd25519()
        let nftCount = 4
        let initialMetadataList =
            Array(repeating: Data([9, 1, 6]), count: nftCount)
        let updatedMetadata = Data([3, 4])
        let updatedMetadataList =
            Array(repeating: updatedMetadata, count: nftCount)

        // Create Token with metadata key included
        let tokenCreateTxReceipt = try await TokenCreateTransaction()
            .name("ffff")
            .symbol("F")
            .tokenType(TokenType.nonFungibleUnique)
            .treasuryAccountId(testEnv.operator.accountId)
            .adminKey(.single(testEnv.operator.privateKey.publicKey))
            .supplyKey(.single(testEnv.operator.privateKey.publicKey))
            .metadataKey(.single(metadataKey.publicKey))
            .expirationTime(.now + .minutes(5))
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let tokenId = try XCTUnwrap(tokenCreateTxReceipt.tokenId)

        // Mint token
        let tokenMintTxReceipt = try await TokenMintTransaction()
            .metadata(initialMetadataList)
            .tokenId(tokenId)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let nftSerials = try XCTUnwrap(tokenMintTxReceipt.serials)
        let metadataList = try await getMetadataList(testEnv.client, tokenId, nftSerials)

        XCTAssertEqual(metadataList, initialMetadataList)

        // Apply new serials & metadata Nft token
        _ = try await TokenUpdateNftsTransaction()
            .tokenId(tokenId)
            .serials(nftSerials)
            .metadata(updatedMetadata)
            .freezeWith(testEnv.client)
            .sign(metadataKey)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let newMetadataList = try await getMetadataList(testEnv.client, tokenId, nftSerials)

        XCTAssertEqual(newMetadataList, updatedMetadataList)
    }

    internal func testUpdateNftMetadataOfPartialCollection() async throws {
        let testEnv = try TestEnvironment.nonFree

        let metadataKey = PrivateKey.generateEd25519()
        let nftCount = 4
        let initialMetadataList =
            Array(repeating: Data([9, 1, 6]), count: nftCount)
        let updatedMetadata = Data([3, 4])
        let updatedMetadataList =
            Array(repeating: updatedMetadata, count: nftCount / 2)

        // Create Token with metadata key included
        let tokenCreateTxReceipt = try await TokenCreateTransaction()
            .name("ffff")
            .symbol("F")
            .tokenType(TokenType.nonFungibleUnique)
            .treasuryAccountId(testEnv.operator.accountId)
            .adminKey(.single(testEnv.operator.privateKey.publicKey))
            .supplyKey(.single(testEnv.operator.privateKey.publicKey))
            .metadataKey(.single(metadataKey.publicKey))
            .expirationTime(.now + .minutes(5))
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let tokenId = try XCTUnwrap(tokenCreateTxReceipt.tokenId)

        // Mint token
        let tokenMintTxReceipt = try await TokenMintTransaction()
            .metadata(initialMetadataList)
            .tokenId(tokenId)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        // Check that the metadata is set correctly
        let nftSerials = try XCTUnwrap(tokenMintTxReceipt.serials)
        let metadataListAfterMint = try await getMetadataList(testEnv.client, tokenId, nftSerials)

        XCTAssertEqual(metadataListAfterMint, initialMetadataList)

        // Update the metadata of the first half of the NFTs
        let nftSerialsToUpdate = nftSerials[..<(nftCount / 2)].map { UInt64($0) }

        // Apply new serials & metadata Nft token
        _ = try await TokenUpdateNftsTransaction()
            .tokenId(tokenId)
            .serials(nftSerialsToUpdate)
            .metadata(updatedMetadata)
            .freezeWith(testEnv.client)
            .sign(metadataKey)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        // Check that the metadata is updated correctly
        let metadataListAfterUpdate = try await getMetadataList(testEnv.client, tokenId, nftSerialsToUpdate)

        XCTAssertEqual(metadataListAfterUpdate, updatedMetadataList)

        let nftSerialsSame = nftSerials[nftCount / 2..<nftCount].map { UInt64($0) }
        let metadataList = try await getMetadataList(testEnv.client, tokenId, nftSerialsSame)

        XCTAssertEqual(metadataList, Array(initialMetadataList[nftCount / 2..<nftCount]) as [Data])
    }

    internal func testCantUpdateMetadataNoSignedMetadataKey() async throws {
        let testEnv = try TestEnvironment.nonFree

        let metadataKey = PrivateKey.generateEd25519()
        let supplyKey = PrivateKey.generateEd25519()
        let nftCount = 4
        let initialMetadataList =
            Array(repeating: Data([9, 1, 6]), count: nftCount)

        let updatedMetadata = Data([3, 4])

        // Create Token with metadata key
        let tokenCreateTxReceipt = try await TokenCreateTransaction()
            .name("ffff")
            .symbol("F")
            .tokenType(TokenType.nonFungibleUnique)
            .treasuryAccountId(testEnv.operator.accountId)
            .adminKey(.single(testEnv.operator.privateKey.publicKey))
            .supplyKey(.single(supplyKey.publicKey))
            .metadataKey(.single(metadataKey.publicKey))
            .expirationTime(.now + .minutes(5))
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let tokenId = try XCTUnwrap(tokenCreateTxReceipt.tokenId)

        let tokenInfo = try await TokenInfoQuery()
            .tokenId(tokenId)
            .execute(testEnv.client)

        XCTAssertEqual(tokenInfo.metadataKey, .single(metadataKey.publicKey))

        // Mint token
        let tokenMintTxReceipt = try await TokenMintTransaction()
            .metadata(initialMetadataList)
            .tokenId(tokenId)
            .freezeWith(testEnv.client)
            .sign(supplyKey)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let nftSerials = try XCTUnwrap(tokenMintTxReceipt.serials)

        await assertThrowsHErrorAsync(
            // Should fail without signature of metadata key
            try await TokenUpdateNftsTransaction()
                .tokenId(tokenId)
                .serials(nftSerials)
                .metadata(updatedMetadata)
                .execute(testEnv.client)
                .getReceipt(testEnv.client)
        ) { error in
            guard case .receiptStatus(let status, transactionId: _) = error.kind else {
                XCTFail("\(error.kind) is not `.receiptStatus(status: _)`")
                return
            }

            XCTAssertEqual(status, .invalidSignature)
        }
    }

    internal func testCantUpdateMetadataNoSetMetadataKey() async throws {
        let testEnv = try TestEnvironment.nonFree

        let metadataKey = PrivateKey.generateEd25519()
        let supplyKey = PrivateKey.generateEd25519()
        let nftCount = 4
        let initialMetadataList = [
            Data(Array(repeating: [9, 1, 6], count: (nftCount / [9, 1, 6].count) + 1).flatMap { $0 }.prefix(nftCount))
        ]
        let updatedMetadata = Data([3, 4])

        // Create token with no set metadata key
        let tokenCreateTxReceipt = try await TokenCreateTransaction()
            .name("ffff")
            .symbol("F")
            .tokenType(TokenType.nonFungibleUnique)
            .treasuryAccountId(testEnv.operator.accountId)
            .adminKey(.single(testEnv.operator.privateKey.publicKey))
            .supplyKey(.single(supplyKey.publicKey))
            .expirationTime(.now + .minutes(5))
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let tokenId = try XCTUnwrap(tokenCreateTxReceipt.tokenId)

        let tokenInfo = try await TokenInfoQuery()
            .tokenId(tokenId)
            .execute(testEnv.client)

        XCTAssertEqual(tokenInfo.metadataKey, nil)

        // Mint token
        let tokenMintTxReceipt = try await TokenMintTransaction()
            .metadata(initialMetadataList)
            .tokenId(tokenId)
            .freezeWith(testEnv.client)
            .sign(supplyKey)
            .execute(testEnv.client)
            .getReceipt(testEnv.client)

        let nftSerials = try XCTUnwrap(tokenMintTxReceipt.serials)

        await assertThrowsHErrorAsync(
            // Should fail without setting metadata key when updating Nft
            try await TokenUpdateNftsTransaction()
                .tokenId(tokenId)
                .serials(nftSerials)
                .metadata(updatedMetadata)
                .freezeWith(testEnv.client)
                .sign(metadataKey)
                .execute(testEnv.client)
                .getReceipt(testEnv.client)

        ) { error in
            guard case .receiptStatus(let status, transactionId: _) = error.kind else {
                XCTFail("\(error.kind) is not `.receiptStatus(status: _)`")
                return
            }

            XCTAssertEqual(status, .invalidSignature)
        }
    }
}

internal func getMetadataList(_ client: Client, _ tokenId: TokenId, _ serials: [UInt64]) async throws -> [Data] {
    let metadataList: [Data] = try await withThrowingTaskGroup(
        of: Data.self,
        body: { group in
            var results = [Data]()

            // Iterate over serials, launching a new task for each
            for serial in serials {
                group.addTask {
                    let nftId = NftId(tokenId: tokenId, serial: UInt64(serial))
                    // Execute the query and return the result
                    return try await TokenNftInfoQuery().nftId(nftId).execute(client).metadata
                }
            }

            // Collect results from all tasks
            for try await result in group {
                results.append(result)
            }

            return results
        })

    return metadataList
}

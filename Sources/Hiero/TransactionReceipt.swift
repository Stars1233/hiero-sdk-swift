// SPDX-License-Identifier: Apache-2.0

import Foundation
import HieroProtobufs

/// The summary of a transaction's result so far, if the transaction has reached consensus.
public struct TransactionReceipt {
    internal init(
        transactionId: TransactionId? = nil,
        status: Status,
        accountId: AccountId? = nil,
        fileId: FileId? = nil,
        contractId: ContractId? = nil,
        topicId: TopicId? = nil,
        topicSequenceNumber: UInt64,
        topicRunningHash: Data? = nil,
        topicRunningHashVersion: UInt64,
        tokenId: TokenId? = nil,
        totalSupply: UInt64,
        scheduleId: ScheduleId? = nil,
        exchangeRates: ExchangeRates? = nil,
        scheduledTransactionId: TransactionId? = nil,
        serials: [UInt64]? = nil,
        duplicates: [TransactionReceipt],
        children: [TransactionReceipt],
        nodeId: UInt64 = 0
    ) {
        self.transactionId = transactionId
        self.status = status
        self.accountId = accountId
        self.fileId = fileId
        self.contractId = contractId
        self.topicId = topicId
        self.topicSequenceNumber = topicSequenceNumber
        self.topicRunningHash = topicRunningHash
        self.topicRunningHashVersion = topicRunningHashVersion
        self.tokenId = tokenId
        self.totalSupply = totalSupply
        self.scheduleId = scheduleId
        self.exchangeRates = exchangeRates
        self.scheduledTransactionId = scheduledTransactionId
        self.serials = serials
        self.duplicates = duplicates
        self.children = children
        self.nodeId = nodeId
    }

    /// The ID of the transaction that this is a receipt for.
    public let transactionId: TransactionId?

    /// The consensus status of the transaction; is UNKNOWN if consensus has not been reached, or if
    /// the associated transaction did not have a valid payer signature.
    public let status: Status

    /// In the receipt for an `AccountCreateTransaction`, the id of the newly created account.
    public let accountId: AccountId?

    /// In the receipt for a `FileCreateTransaction`, the id of the newly created file.
    public let fileId: FileId?

    /// In the receipt for a `ContractCreateTransaction`, the id of the newly created contract.
    public let contractId: ContractId?

    /// In the receipt for a `TopicCreateTransaction`, the id of the newly created topic.
    public let topicId: TopicId?

    /// In the receipt for a `TopicMessageSubmitTransaction`, the new sequence number of the topic
    /// that received the message.
    public let topicSequenceNumber: UInt64

    // TODO: hash type (?)
    /// In the receipt for a `TopicMessageSubmitTransaction`, the new running hash of the
    /// topic that received the message.
    public let topicRunningHash: Data?

    /// In the receipt of a `TopicMessageSubmitTransaction`, the version of the SHA-384
    /// digest used to update the running hash.
    public let topicRunningHashVersion: UInt64

    /// In the receipt for a `TokenCreateTransaction`, the id of the newly created token.
    public let tokenId: TokenId?

    /// Populated in the receipt of `TokenMint`, `TokenWipe`, and `TokenBurn` transactions.
    ///
    /// For fungible tokens, the current total supply of this token.
    /// For non-fungible tokens, the total number of NFTs issued for a given token id.
    public let totalSupply: UInt64

    /// In the receipt for a `ScheduleCreateTransaction`, the id of the newly created schedule.
    public let scheduleId: ScheduleId?

    /// The current exchange rate between Hbar and USD-cents.
    ///
    /// This exists purely for "Well, I expected this name to exist because it exists in JS"
    ///
    /// This is just a getter property for `current` in ``TransactionReceipt/exchangeRates``
    public var exchangeRate: ExchangeRate? {
        exchangeRates?.currentRate
    }

    /// The current and next exchange rate between Hbar and USD-cents.
    public let exchangeRates: ExchangeRates?

    /// In the receipt of a `ScheduleCreateTransaction` or `ScheduleSignTransaction` that resolves
    /// to `Success`, the `TransactionId` that should be used to query for the receipt or
    /// record of the relevant scheduled transaction.
    public let scheduledTransactionId: TransactionId?

    /// In the receipt of a `TokenMintTransaction` for tokens of type `NonFungibleUnique`,
    /// the serial numbers of the newly created NFTs.
    public let serials: [UInt64]?

    /// The receipts of processing all transactions with the given id, in consensus time order.
    public let duplicates: [TransactionReceipt]

    /// The receipts (if any) of all child transactions spawned by the transaction with the
    /// given top-level id, in consensus order.
    public let children: [TransactionReceipt]

    /// In the receipt of a NodeCreate, NodeUpdate, NodeDelete, the id of the newly created node.
    /// An affected node identifier.
    public let nodeId: UInt64

    internal init(
        protobuf proto: Proto_TransactionReceipt,
        duplicates: [TransactionReceipt],
        children: [TransactionReceipt],
        transactionId: TransactionId?
    ) throws {
        let accountId = proto.hasAccountID ? proto.accountID : nil
        let fileId = proto.hasFileID ? proto.fileID : nil
        let contractId = proto.hasContractID ? proto.contractID : nil
        let topicId = proto.hasTopicID ? proto.topicID : nil
        let topicRunningHash = !proto.topicRunningHash.isEmpty ? proto.topicRunningHash : nil
        let tokenId = proto.hasTokenID ? proto.tokenID : nil
        let scheduleId = proto.hasScheduleID ? proto.scheduleID : nil
        let scheduledTransactionId = proto.hasScheduledTransactionID ? proto.scheduledTransactionID : nil
        let serials = !proto.serialNumbers.isEmpty ? proto.serialNumbers : nil
        self.init(
            transactionId: transactionId,
            status: Status(rawValue: Int32(proto.status.rawValue)),
            accountId: try .fromProtobuf(accountId),
            fileId: .fromProtobuf(fileId),
            contractId: try .fromProtobuf(contractId),
            topicId: .fromProtobuf(topicId),
            topicSequenceNumber: proto.topicSequenceNumber,
            topicRunningHash: topicRunningHash,
            topicRunningHashVersion: proto.topicRunningHashVersion,
            tokenId: .fromProtobuf(tokenId),
            totalSupply: proto.newTotalSupply,
            scheduleId: .fromProtobuf(scheduleId),
            scheduledTransactionId: try .fromProtobuf(scheduledTransactionId),
            serials: serials?.map(UInt64.init),
            duplicates: duplicates,
            children: children
        )
    }

    /// Validate the receipt status and throw an error if it isn't successful.
    @discardableResult
    public func validateStatus(_ doValidate: Bool) throws -> Self {
        if doValidate && status != .success {
            throw HError(
                kind: .receiptStatus(status: status, transactionId: transactionId),
                description:
                    "receipt for transaction `\(String(describing: transactionId))` failed with status `\(status)`"
            )
        }

        return self
    }

    /// Decode `Self` from protobuf-encoded `bytes`.
    ///
    /// - Throws: ``HError/ErrorKind/fromProtobuf`` if:
    ///           decoding the bytes fails to produce a valid protobuf, or
    ///            decoding the protobuf fails.
    public static func fromBytes(_ bytes: Data) throws -> Self {
        try Self(protobufBytes: bytes)
    }

    /// Convert `self` to protobuf encoded data.
    public func toBytes() -> Data {
        toProtobufBytes()
    }
}

extension TransactionReceipt: TryProtobufCodable {
    internal typealias Protobuf = Proto_TransactionReceipt

    internal init(protobuf proto: Protobuf) throws {
        try self.init(protobuf: proto, duplicates: [], children: [], transactionId: nil)
    }

    internal func toProtobuf() -> Protobuf {
        .with { proto in
            proto.status = Proto_ResponseCodeEnum(rawValue: Int(status.rawValue))!
            accountId?.toProtobufInto(&proto.accountID)
            fileId?.toProtobufInto(&proto.fileID)
            contractId?.toProtobufInto(&proto.contractID)
            topicId?.toProtobufInto(&proto.topicID)
            proto.topicSequenceNumber = topicSequenceNumber
            proto.topicRunningHash = topicRunningHash ?? Data()
            proto.topicRunningHashVersion = topicRunningHashVersion
            tokenId?.toProtobufInto(&proto.tokenID)
            proto.newTotalSupply = totalSupply
            scheduleId?.toProtobufInto(&proto.scheduleID)
            exchangeRates?.toProtobufInto(&proto.exchangeRate)
            scheduledTransactionId?.toProtobufInto(&proto.scheduledTransactionID)
            proto.serialNumbers = serials?.map(Int64.init) ?? []
            proto.nodeID = nodeId
        }
    }
}

#if compiler(>=5.7)
    extension TransactionReceipt: Sendable {}
#else
    // Swift 5.7 added the conformance to data, despite to the best of my knowledge, not changing anything in the underlying type.
    extension TransactionReceipt: @unchecked Sendable {}
#endif

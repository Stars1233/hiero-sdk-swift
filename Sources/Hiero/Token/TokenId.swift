// SPDX-License-Identifier: Apache-2.0

import Foundation
import HieroProtobufs

/// The unique identifier for a token on Hiero.
public struct TokenId: EntityId, ValidateChecksums, Sendable, Equatable, Comparable {
    public init(shard: UInt64 = 0, realm: UInt64 = 0, num: UInt64, checksum: Checksum?) {
        self.shard = shard
        self.realm = realm
        self.num = num
        self.checksum = checksum
    }

    public init(shard: UInt64 = 0, realm: UInt64 = 0, num: UInt64) {
        self.init(shard: shard, realm: realm, num: num, checksum: nil)
    }

    public let shard: UInt64
    public let realm: UInt64

    /// The token number.
    public let num: UInt64

    public let checksum: Checksum?

    public static func fromBytes(_ bytes: Data) throws -> Self {
        try Self(protobufBytes: bytes)
    }

    public func toBytes() -> Data {
        toProtobufBytes()
    }

    public func nft(_ serial: UInt64) -> NftId {
        NftId(tokenId: self, serial: serial)
    }

    internal func validateChecksums(on ledgerId: LedgerId) throws {
        try helper.validateChecksum(on: ledgerId)
    }

    public static func < (lhs: TokenId, rhs: TokenId) -> Bool {
        if lhs.shard != rhs.shard {
            return lhs.shard < rhs.shard
        }
        if lhs.realm != rhs.realm {
            return lhs.realm < rhs.realm
        }
        return lhs.num < rhs.num
    }
}

extension TokenId: ProtobufCodable {
    internal typealias Protobuf = HieroProtobufs.Proto_TokenID

    internal init(protobuf proto: Protobuf) {
        self.init(
            shard: UInt64(proto.shardNum),
            realm: UInt64(proto.realmNum),
            num: UInt64(proto.tokenNum)
        )
    }

    internal func toProtobuf() -> Protobuf {
        .with { proto in
            proto.shardNum = Int64(shard)
            proto.realmNum = Int64(realm)
            proto.tokenNum = Int64(num)
        }
    }
}

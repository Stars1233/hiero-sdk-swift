// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: services/token_get_account_nft_infos.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

///*
/// # Get Account NFT Infos
/// Deprecated and permanently disabled
///
/// ### Keywords
/// The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
/// "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
/// document are to be interpreted as described in
/// [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
/// [RFC8174](https://www.ietf.org/rfc/rfc8174).

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

///*
/// Deleted and unsupported.
///
/// This query is not implemented and any query of this type submitted
/// SHALL return a `NOT_SUPPORTED` response code.
public struct Proto_TokenGetAccountNftInfosQuery: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///*
  /// Standard information sent with every query operation.<br/>
  /// This includes the signed payment and what kind of response is requested
  /// (cost, state proof, both, or neither).
  public var header: Proto_QueryHeader {
    get {return _header ?? Proto_QueryHeader()}
    set {_header = newValue}
  }
  /// Returns true if `header` has been explicitly set.
  public var hasHeader: Bool {return self._header != nil}
  /// Clears the value of `header`. Subsequent reads from it will return its default value.
  public mutating func clearHeader() {self._header = nil}

  ///*
  /// The Account for which information is requested
  public var accountID: Proto_AccountID {
    get {return _accountID ?? Proto_AccountID()}
    set {_accountID = newValue}
  }
  /// Returns true if `accountID` has been explicitly set.
  public var hasAccountID: Bool {return self._accountID != nil}
  /// Clears the value of `accountID`. Subsequent reads from it will return its default value.
  public mutating func clearAccountID() {self._accountID = nil}

  ///*
  /// Specifies the start index (inclusive) of the range of NFTs to query for.
  /// Value must be in the range [0; ownedNFTs-1]
  public var start: Int64 = 0

  ///*
  /// Specifies the end index (exclusive) of the range of NFTs to query for.
  /// Value must be in the range (start; ownedNFTs]
  public var end: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _header: Proto_QueryHeader? = nil
  fileprivate var _accountID: Proto_AccountID? = nil
}

///*
/// Deleted and unsupported.
public struct Proto_TokenGetAccountNftInfosResponse: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///*
  /// The standard response information for queries.<br/>
  /// This includes the values requested in the `QueryHeader`
  /// (cost, state proof, both, or neither).
  public var header: Proto_ResponseHeader {
    get {return _header ?? Proto_ResponseHeader()}
    set {_header = newValue}
  }
  /// Returns true if `header` has been explicitly set.
  public var hasHeader: Bool {return self._header != nil}
  /// Clears the value of `header`. Subsequent reads from it will return its default value.
  public mutating func clearHeader() {self._header = nil}

  ///*
  /// List of NFTs associated to the account
  public var nfts: [Proto_TokenNftInfo] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _header: Proto_ResponseHeader? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_TokenGetAccountNftInfosQuery: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TokenGetAccountNftInfosQuery"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "accountID"),
    3: .same(proto: "start"),
    4: .same(proto: "end"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._header) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._accountID) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.start) }()
      case 4: try { try decoder.decodeSingularInt64Field(value: &self.end) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._header {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._accountID {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if self.start != 0 {
      try visitor.visitSingularInt64Field(value: self.start, fieldNumber: 3)
    }
    if self.end != 0 {
      try visitor.visitSingularInt64Field(value: self.end, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_TokenGetAccountNftInfosQuery, rhs: Proto_TokenGetAccountNftInfosQuery) -> Bool {
    if lhs._header != rhs._header {return false}
    if lhs._accountID != rhs._accountID {return false}
    if lhs.start != rhs.start {return false}
    if lhs.end != rhs.end {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_TokenGetAccountNftInfosResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TokenGetAccountNftInfosResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "nfts"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._header) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.nfts) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._header {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.nfts.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.nfts, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_TokenGetAccountNftInfosResponse, rhs: Proto_TokenGetAccountNftInfosResponse) -> Bool {
    if lhs._header != rhs._header {return false}
    if lhs.nfts != rhs.nfts {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

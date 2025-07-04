// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: services/token_update_nfts.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

///*
/// # Token Update NFTs
/// Given a token identifier and a metadata block, change the metadata for
/// one or more non-fungible/unique token instances.
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
/// Modify the metadata field for an individual non-fungible/unique token (NFT).
///
/// Updating the metadata of an NFT SHALL NOT affect ownership or
/// the ability to transfer that NFT.<br/>
/// This transaction SHALL affect only the specific serial numbered tokens
/// identified.
/// This transaction SHALL modify individual token metadata.<br/>
/// This transaction MUST be signed by the token `metadata_key`.<br/>
/// The token `metadata_key` MUST be a valid `Key`.<br/>
/// The token `metadata_key` MUST NOT be an empty `KeyList`.
///
/// ### Block Stream Effects
/// None
public struct Proto_TokenUpdateNftsTransactionBody: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///*
  /// A token identifier.<br/>
  /// This is the token type (i.e. collection) for which to update NFTs.
  /// <p>
  /// This field is REQUIRED.<br/>
  /// The identified token MUST exist, MUST NOT be paused, MUST have the type
  /// non-fungible/unique, and MUST have a valid `metadata_key`.
  public var token: Proto_TokenID {
    get {return _token ?? Proto_TokenID()}
    set {_token = newValue}
  }
  /// Returns true if `token` has been explicitly set.
  public var hasToken: Bool {return self._token != nil}
  /// Clears the value of `token`. Subsequent reads from it will return its default value.
  public mutating func clearToken() {self._token = nil}

  ///*
  /// A list of serial numbers to be updated.
  /// <p>
  /// This field is REQUIRED.<br/>
  /// This list MUST have at least one(1) entry.<br/>
  /// This list MUST NOT have more than ten(10) entries.
  public var serialNumbers: [Int64] = []

  ///*
  /// A new value for the metadata.
  /// <p>
  /// If this field is not set, the metadata SHALL NOT change.<br/>
  /// This value, if set, MUST NOT exceed 100 bytes.
  public var metadata: SwiftProtobuf.Google_Protobuf_BytesValue {
    get {return _metadata ?? SwiftProtobuf.Google_Protobuf_BytesValue()}
    set {_metadata = newValue}
  }
  /// Returns true if `metadata` has been explicitly set.
  public var hasMetadata: Bool {return self._metadata != nil}
  /// Clears the value of `metadata`. Subsequent reads from it will return its default value.
  public mutating func clearMetadata() {self._metadata = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _token: Proto_TokenID? = nil
  fileprivate var _metadata: SwiftProtobuf.Google_Protobuf_BytesValue? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_TokenUpdateNftsTransactionBody: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TokenUpdateNftsTransactionBody"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "token"),
    2: .standard(proto: "serial_numbers"),
    3: .same(proto: "metadata"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._token) }()
      case 2: try { try decoder.decodeRepeatedInt64Field(value: &self.serialNumbers) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._metadata) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._token {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.serialNumbers.isEmpty {
      try visitor.visitPackedInt64Field(value: self.serialNumbers, fieldNumber: 2)
    }
    try { if let v = self._metadata {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_TokenUpdateNftsTransactionBody, rhs: Proto_TokenUpdateNftsTransactionBody) -> Bool {
    if lhs._token != rhs._token {return false}
    if lhs.serialNumbers != rhs.serialNumbers {return false}
    if lhs._metadata != rhs._metadata {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

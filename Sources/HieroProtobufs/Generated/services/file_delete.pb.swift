// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: services/file_delete.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

///*
/// # File Delete
/// A message for a transaction to delete a file.
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
/// Mark a file as deleted and remove its content from network state.
///
/// The metadata for a deleted file SHALL be retained at least until the
/// expiration time for the file is exceeded.<br/>
/// On completion, the identified file SHALL be marked `deleted`.<br/>
/// On completion, the identified file SHALL have an empty `contents` array.<br/>
/// This transaction SHALL be final and irreversible.<br/>
///
/// #### Signature Requirements
/// At least _one_ key from the `KeyList` in the `keys` field of the
/// identified file MUST sign this transaction.<br/>
/// If the keys field for the identified file is an empty `KeyList` (because that
/// file was previously created or updated to have an empty `KeyList`), then the
/// file is considered immutable and this message SHALL fail as UNAUTHORIZED.
/// See the [File Service](#FileService) specification for a detailed
/// explanation of the signature requirements for all file transactions.
///
/// ### What is a "system" file
/// A "system" file is any file with a file number less than or equal to the
/// current configuration value for `ledger.numReservedSystemEntities`,
/// typically `750`.
///
/// ### Block Stream Effects
/// None
public struct Proto_FileDeleteTransactionBody: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///*
  /// A file identifier.<br/>
  /// This identifies the file to delete.
  /// <p>
  /// The identified file MUST NOT be a "system" file.<br/>
  /// This field is REQUIRED.
  public var fileID: Proto_FileID {
    get {return _fileID ?? Proto_FileID()}
    set {_fileID = newValue}
  }
  /// Returns true if `fileID` has been explicitly set.
  public var hasFileID: Bool {return self._fileID != nil}
  /// Clears the value of `fileID`. Subsequent reads from it will return its default value.
  public mutating func clearFileID() {self._fileID = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _fileID: Proto_FileID? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_FileDeleteTransactionBody: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".FileDeleteTransactionBody"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    2: .same(proto: "fileID"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 2: try { try decoder.decodeSingularMessageField(value: &self._fileID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._fileID {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_FileDeleteTransactionBody, rhs: Proto_FileDeleteTransactionBody) -> Bool {
    if lhs._fileID != rhs._fileID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

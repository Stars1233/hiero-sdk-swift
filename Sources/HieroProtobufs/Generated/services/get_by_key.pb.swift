// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: services/get_by_key.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

///*
/// # Get By Key
/// An obsolete query to obtain a list of entities that refer to
/// a given Key object.<br/>
/// Returned entities may be accounts, files, smart contracts, and/or
/// live hash entries.
///
/// > Important
/// >> This query is obsolete and not supported.<br/>
/// >> Any query of this type that is submitted SHALL fail with a `PRE_CHECK`
/// >> result of `NOT_SUPPORTED`.
///
/// > Implementation Note
/// >> This query is not defined for any service, and while it is implemented
/// >> in the "Network Admin" service, it may be unnecessary to do so.
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
/// Query all accounts, claims, files, and smart contract instances whose
/// associated keys include the given Key.
///
/// > This query is no longer supported.
///
/// NOTE: This message was marked as deprecated in the .proto file.
public struct Proto_GetByKeyQuery: Sendable {
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
  /// The key to search for. It MUST NOT contain a contractID nor
  /// a ThresholdKey.
  public var key: Proto_Key {
    get {return _key ?? Proto_Key()}
    set {_key = newValue}
  }
  /// Returns true if `key` has been explicitly set.
  public var hasKey: Bool {return self._key != nil}
  /// Clears the value of `key`. Subsequent reads from it will return its default value.
  public mutating func clearKey() {self._key = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _header: Proto_QueryHeader? = nil
  fileprivate var _key: Proto_Key? = nil
}

///*
/// The ID for a single entity (account, livehash, file, or smart contract)
///
/// > The query that defines this message is no longer supported.
///
/// NOTE: This message was marked as deprecated in the .proto file.
public struct Proto_EntityID: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var entity: Proto_EntityID.OneOf_Entity? = nil

  ///*
  /// The Account ID for the cryptocurrency account
  public var accountID: Proto_AccountID {
    get {
      if case .accountID(let v)? = entity {return v}
      return Proto_AccountID()
    }
    set {entity = .accountID(newValue)}
  }

  ///*
  /// A uniquely identifying livehash of an account
  public var liveHash: Proto_LiveHash {
    get {
      if case .liveHash(let v)? = entity {return v}
      return Proto_LiveHash()
    }
    set {entity = .liveHash(newValue)}
  }

  ///*
  /// The file ID of the file
  public var fileID: Proto_FileID {
    get {
      if case .fileID(let v)? = entity {return v}
      return Proto_FileID()
    }
    set {entity = .fileID(newValue)}
  }

  ///*
  /// The smart contract ID that identifies instance
  public var contractID: Proto_ContractID {
    get {
      if case .contractID(let v)? = entity {return v}
      return Proto_ContractID()
    }
    set {entity = .contractID(newValue)}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_Entity: Equatable, Sendable {
    ///*
    /// The Account ID for the cryptocurrency account
    case accountID(Proto_AccountID)
    ///*
    /// A uniquely identifying livehash of an account
    case liveHash(Proto_LiveHash)
    ///*
    /// The file ID of the file
    case fileID(Proto_FileID)
    ///*
    /// The smart contract ID that identifies instance
    case contractID(Proto_ContractID)

  }

  public init() {}
}

///*
/// Response when the client sends the node GetByKeyQuery
///
/// > This query is no longer supported.
///
/// NOTE: This message was marked as deprecated in the .proto file.
public struct Proto_GetByKeyResponse: Sendable {
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
  /// The list of entities that include this public key in their
  /// associated Key list
  public var entities: [Proto_EntityID] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _header: Proto_ResponseHeader? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "proto"

extension Proto_GetByKeyQuery: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetByKeyQuery"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "key"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._header) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._key) }()
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
    try { if let v = self._key {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_GetByKeyQuery, rhs: Proto_GetByKeyQuery) -> Bool {
    if lhs._header != rhs._header {return false}
    if lhs._key != rhs._key {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_EntityID: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".EntityID"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "accountID"),
    2: .same(proto: "liveHash"),
    3: .same(proto: "fileID"),
    4: .same(proto: "contractID"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Proto_AccountID?
        var hadOneofValue = false
        if let current = self.entity {
          hadOneofValue = true
          if case .accountID(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.entity = .accountID(v)
        }
      }()
      case 2: try {
        var v: Proto_LiveHash?
        var hadOneofValue = false
        if let current = self.entity {
          hadOneofValue = true
          if case .liveHash(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.entity = .liveHash(v)
        }
      }()
      case 3: try {
        var v: Proto_FileID?
        var hadOneofValue = false
        if let current = self.entity {
          hadOneofValue = true
          if case .fileID(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.entity = .fileID(v)
        }
      }()
      case 4: try {
        var v: Proto_ContractID?
        var hadOneofValue = false
        if let current = self.entity {
          hadOneofValue = true
          if case .contractID(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.entity = .contractID(v)
        }
      }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.entity {
    case .accountID?: try {
      guard case .accountID(let v)? = self.entity else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .liveHash?: try {
      guard case .liveHash(let v)? = self.entity else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .fileID?: try {
      guard case .fileID(let v)? = self.entity else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case .contractID?: try {
      guard case .contractID(let v)? = self.entity else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_EntityID, rhs: Proto_EntityID) -> Bool {
    if lhs.entity != rhs.entity {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Proto_GetByKeyResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetByKeyResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .same(proto: "entities"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._header) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.entities) }()
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
    if !self.entities.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.entities, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Proto_GetByKeyResponse, rhs: Proto_GetByKeyResponse) -> Bool {
    if lhs._header != rhs._header {return false}
    if lhs.entities != rhs.entities {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

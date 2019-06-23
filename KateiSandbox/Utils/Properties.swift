//
//  Properties.swift
//  KateiSandbox
//
//  Created by kateinoigakukun on 2019/06/23.
//  Copyright © 2019 kateinoigakukun. All rights reserved.
//

struct RelativePointer<Pointee> {
    let offset: Int32
    
    mutating func advanced() -> UnsafeMutablePointer<Pointee> {
        withUnsafePointer(to: &self) { [offset] ptr in
            let raw = UnsafeRawPointer(ptr)
            let advanced = raw.advanced(by: Int(offset))
            let pointer = advanced.assumingMemoryBound(to: Pointee.self)
            return UnsafeMutablePointer(mutating: pointer)
        }
    }
}

struct VectorPointer<Pointee> {
    let offset: Int32
    
    mutating func vector(size: Int) -> [Pointee] {
        withUnsafePointer(to: &self) { ptr in
            let base = UnsafeRawPointer(ptr).assumingMemoryBound(to: Pointee.self)
            return (0..<size).map { base.advanced(by: $0).pointee }
        }
    }
    
    mutating func map<U>(size: Int, transform: (UnsafeMutablePointer<Pointee>) -> U) -> [U] {
        withUnsafePointer(to: &self) { ptr in
            let base = UnsafeRawPointer(ptr).assumingMemoryBound(to: Pointee.self)
            return (0..<size).map {
                transform(UnsafeMutablePointer(mutating: base.advanced(by: $0)))
            }
        }
    }
}

struct FD {
    var mangledTypeName: RelativePointer<CChar>
    var superClass: RelativePointer<Int32>
    var fieldDescriptorKind: UInt16
    var fieldRecordSize: Int16
    var numFields: Int32
    
    var fields: VectorPointer<FieldRecord>
}

struct FieldRecord {
    let fieldRecordFlags: Int32
    var mangledTypeName: RelativePointer<CChar>
    var fieldName: RelativePointer<CChar>
}

struct StructMD {
    var kind: Int
    var ntd: UnsafeMutablePointer<StructDesc>
}
struct StructDesc {
    let space1: Int64
    let space2: Int64
    var fd: RelativePointer<FD>
    var numberOfFields: Int32
}

struct ClassMD {
    var kind: Int16
    var sp1: Int64
    var sp2: Int64
    var sp3: Int64
    var sp4: Int64
    var sp5: Int64
    var sp6: Int64
    var sp7: UInt64
    var sp8: Int64
    var ntd: UnsafeMutablePointer<ClassDesc>
}

struct ClassDesc {
    var sp0: Int64
    var mangledName: RelativePointer<CChar>
    let sp1: Int32
    var fd: RelativePointer<FD>
    var sp2: Int64
    var sp3: Int32
    var numberOfFields: Int32
}

func struct_properties(of type: Any.Type) -> [(name: String, typeName: Any.Type)] {
    let md = unsafeBitCast(type, to: UnsafeMutablePointer<StructMD>.self)
    let fields = md.pointee
        .ntd.pointee
        .fd.advanced().pointee
        .fields
        .map(size: Int(md.pointee.ntd.pointee.numberOfFields)) { record in
            (
                String(cString: record.pointee.fieldName.advanced()),
                _typeByName(String(cString: record.pointee.mangledTypeName.advanced()))!
            )
    }
    return fields
}

func class_properties(of type: Any.Type) -> [(name: String, typeName: Any.Type?)] {
    let md = unsafeBitCast(type, to: UnsafeMutablePointer<ClassMD>.self)
    print(md.pointee.ntd.pointee.numberOfFields)
    let fields = md.pointee
        .ntd.pointee
        .fd.advanced().pointee
        .fields
        .map(size: Int(md.pointee.ntd.pointee.numberOfFields)) { record in
            (
                String(cString: record.pointee.fieldName.advanced()),
                _typeByName(String(cString: record.pointee.mangledTypeName.advanced()))
            )
    }
    return fields
}

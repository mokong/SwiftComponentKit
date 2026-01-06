//
//  Optional+WrapNil.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension Optional {
    /// 如果为nil则返回默认值
    /// - Parameter defaultValue: 默认值
    /// - Returns: 解包后的值或默认值
    public func sck_wrapNil<T>(_ defaultValue: T) -> T where Wrapped == T {
        return self ?? defaultValue
    }
}

extension Optional where Wrapped == String {
    public var sck_wrapEmpty: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    public var sck_wrapZero: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    public var sck_wrapZero: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Bool {
    public var sck_wrapFalse: Bool {
        return self ?? false
    }
    
    public var sck_wrapTrue: Bool {
        return self ?? true
    }
}

extension Optional where Wrapped == Array<Any> {
    public var sck_wrapEmpty: [Any] {
        return self ?? []
    }
}

extension Optional where Wrapped == [String] {
    public var sck_wrapEmpty: [String] {
        return self ?? []
    }
}

extension Optional where Wrapped == [String: Any] {
    public var sck_wrapEmpty: [String: Any] {
        return self ?? [:]
    }
}


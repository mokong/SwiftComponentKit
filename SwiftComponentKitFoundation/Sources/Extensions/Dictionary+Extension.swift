//
//  Dictionary+Extension.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension Dictionary {
    /// 安全访问
    /// - Parameters:
    ///   - key: 键
    ///   - type: 期望的类型
    /// - Returns: 值，如果不存在或类型不匹配返回nil
    public func sck_value<T>(forKey key: Key, as type: T.Type) -> T? {
        guard let value = self[key] else { return nil }
        return value as? T
    }
    
    /// 合并字典
    /// - Parameter other: 要合并的字典
    /// - Returns: 合并后的字典
    public func sck_merging(_ other: [Key: Value]) -> [Key: Value] {
        var result = self
        for (key, value) in other {
            result[key] = value
        }
        return result
    }
    
    /// 转换为JSON字符串
    public var sck_jsonString: String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary where Key == String {
    /// 从JSON字符串创建字典
    /// - Parameter jsonString: JSON字符串
    /// - Returns: 字典，如果解析失败返回nil
    public static func sck_from(jsonString: String) -> [String: Any]? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}


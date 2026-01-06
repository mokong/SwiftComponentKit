//
//  SCKKeychain.swift
//  SwiftComponentKitStorage
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import Security

/// Keychain封装
public class SCKKeychain {
    /// 存储数据
    /// - Parameters:
    ///   - value: 要存储的值
    ///   - key: 键
    /// - Returns: 是否成功
    public static func set(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // 先删除旧数据
        SecItemDelete(query as CFDictionary)
        
        // 添加新数据
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// 获取数据
    /// - Parameter key: 键
    /// - Returns: 值，如果不存在返回nil
    public static func get(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    /// 删除数据
    /// - Parameter key: 键
    /// - Returns: 是否成功
    public static func delete(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
    
    /// 清空所有数据（当前应用的）
    /// - Returns: 是否成功
    public static func clear() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}


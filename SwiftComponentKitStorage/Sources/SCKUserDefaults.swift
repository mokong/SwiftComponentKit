//
//  SCKUserDefaults.swift
//  SwiftComponentKitStorage
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// UserDefaults封装
public class SCKUserDefaults {
    public static let standard = SCKUserDefaults()
    
    private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// 存储值
    /// - Parameters:
    ///   - value: 要存储的值
    ///   - key: 键
    public func set<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    /// 获取值
    /// - Parameters:
    ///   - type: 类型
    ///   - key: 键
    /// - Returns: 值，如果不存在返回nil
    public func get<T>(_ type: T.Type, forKey key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }
    
    /// 获取值（带默认值）
    /// - Parameters:
    ///   - type: 类型
    ///   - key: 键
    ///   - defaultValue: 默认值
    /// - Returns: 值或默认值
    public func get<T>(_ type: T.Type, forKey key: String, defaultValue: T) -> T {
        return get(type, forKey: key) ?? defaultValue
    }
    
    /// 删除值
    /// - Parameter key: 键
    public func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    
    /// 检查是否存在
    /// - Parameter key: 键
    /// - Returns: 是否存在
    public func exists(forKey key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}

// MARK: - 便捷扩展
extension SCKUserDefaults {
    /// 存储字符串
    public func setString(_ value: String, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取字符串
    public func getString(forKey key: String) -> String? {
        return get(String.self, forKey: key)
    }
    
    /// 存储整数
    public func setInt(_ value: Int, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取整数
    public func getInt(forKey key: String) -> Int? {
        return get(Int.self, forKey: key)
    }
    
    /// 存储布尔值
    public func setBool(_ value: Bool, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取布尔值
    public func getBool(forKey key: String) -> Bool? {
        return get(Bool.self, forKey: key)
    }
    
    /// 存储双精度浮点数
    public func setDouble(_ value: Double, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取双精度浮点数
    public func getDouble(forKey key: String) -> Double? {
        return get(Double.self, forKey: key)
    }
    
    /// 存储数据
    public func setData(_ value: Data, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取数据
    public func getData(forKey key: String) -> Data? {
        return get(Data.self, forKey: key)
    }
}


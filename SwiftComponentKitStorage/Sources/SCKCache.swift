//
//  SCKCache.swift
//  SwiftComponentKitStorage
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import SwiftComponentKitFoundation

/// 缓存管理器
public class SCKCache {
    public static let shared = SCKCache()
    
    private let memoryCache = NSCache<NSString, AnyObject>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        memoryCache.countLimit = 100
        memoryCache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("SCKCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    /// 设置内存缓存
    /// - Parameters:
    ///   - value: 要缓存的值
    ///   - key: 键
    public func setMemoryCache(_ value: Any, forKey key: String) {
        memoryCache.setObject(value as AnyObject, forKey: key as NSString)
    }
    
    /// 获取内存缓存
    /// - Parameters:
    ///   - key: 键
    ///   - type: 类型
    /// - Returns: 值，如果不存在返回nil
    public func getMemoryCache<T>(forKey key: String, as type: T.Type) -> T? {
        return memoryCache.object(forKey: key as NSString) as? T
    }
    
    /// 设置磁盘缓存
    /// - Parameters:
    ///   - value: 要缓存的数据
    ///   - key: 键
    public func setDiskCache(_ value: Data, forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key.sck_md5)
        try? value.write(to: fileURL)
    }
    
    /// 获取磁盘缓存
    /// - Parameter key: 键
    /// - Returns: 数据，如果不存在返回nil
    public func getDiskCache(forKey key: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(key.sck_md5)
        return try? Data(contentsOf: fileURL)
    }
    
    /// 清除内存缓存
    public func clearMemoryCache() {
        memoryCache.removeAllObjects()
    }
    
    /// 清除磁盘缓存
    public func clearDiskCache() {
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    /// 清除所有缓存
    public func clearAllCache() {
        clearMemoryCache()
        clearDiskCache()
    }
    
    /// 获取磁盘缓存大小
    public var diskCacheSize: Int64 {
        guard let enumerator = fileManager.enumerator(atPath: cacheDirectory.path) else {
            return 0
        }
        
        var totalSize: Int64 = 0
        for file in enumerator {
            if let filePath = file as? String {
                let fullPath = cacheDirectory.appendingPathComponent(filePath).path
                if let attributes = try? fileManager.attributesOfItem(atPath: fullPath),
                   let size = attributes[.size] as? Int64 {
                    totalSize += size
                }
            }
        }
        return totalSize
    }
}


//
//  SCKImageCache.swift
//  SwiftComponentKitImage
//
//  Created by mokong on 2026/01/06.
//

import UIKit
import CommonCrypto

/// 图片缓存管理器
public class SCKImageCache {
    public static let shared = SCKImageCache()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        memoryCache.countLimit = 50
        memoryCache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("SCKImageCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    /// 获取图片
    /// - Parameter key: 缓存键（通常是URL）
    /// - Returns: 图片，如果不存在返回nil
    public func getImage(forKey key: String) -> UIImage? {
        // 先查内存缓存
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        }
        
        // 再查磁盘缓存
        let fileURL = cacheDirectory.appendingPathComponent(md5Hash(key))
        if let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    /// 设置图片
    /// - Parameters:
    ///   - image: 要缓存的图片
    ///   - key: 缓存键（通常是URL）
    public func setImage(_ image: UIImage, forKey key: String) {
        // 存入内存缓存
        memoryCache.setObject(image, forKey: key as NSString)
        
        // 存入磁盘缓存
        let fileURL = cacheDirectory.appendingPathComponent(md5Hash(key))
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
    
    /// 清除缓存
    public func clearCache() {
        memoryCache.removeAllObjects()
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    /// 计算MD5哈希（简化实现）
    private func md5Hash(_ string: String) -> String {
        let data = Data(string.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}


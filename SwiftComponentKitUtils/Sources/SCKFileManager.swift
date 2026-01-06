//
//  SCKFileManager.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// 文件管理器
public class SCKFileManager {
    /// Documents目录
    public static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    /// Cache目录
    public static var cacheDirectory: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    /// Temporary目录
    public static var temporaryDirectory: URL {
        return FileManager.default.temporaryDirectory
    }
    
    /// 文件是否存在
    /// - Parameter path: 文件路径
    /// - Returns: 是否存在
    public static func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    /// 创建目录
    /// - Parameter path: 目录路径
    /// - Returns: 是否成功
    public static func createDirectory(at path: String) -> Bool {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            return false
        }
    }
    
    /// 删除文件
    /// - Parameter path: 文件路径
    /// - Returns: 是否成功
    public static func deleteFile(at path: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
    
    /// 复制文件
    /// - Parameters:
    ///   - from: 源路径
    ///   - to: 目标路径
    /// - Returns: 是否成功
    public static func copyFile(from: String, to: String) -> Bool {
        do {
            try FileManager.default.copyItem(atPath: from, toPath: to)
            return true
        } catch {
            return false
        }
    }
    
    /// 移动文件
    /// - Parameters:
    ///   - from: 源路径
    ///   - to: 目标路径
    /// - Returns: 是否成功
    public static func moveFile(from: String, to: String) -> Bool {
        do {
            try FileManager.default.moveItem(atPath: from, toPath: to)
            return true
        } catch {
            return false
        }
    }
    
    /// 获取文件大小
    /// - Parameter path: 文件路径
    /// - Returns: 文件大小（字节），如果失败返回nil
    public static func fileSize(at path: String) -> Int64? {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: path),
              let size = attributes[.size] as? Int64 else {
            return nil
        }
        return size
    }
    
    /// 获取目录大小
    /// - Parameter path: 目录路径
    /// - Returns: 目录大小（字节），如果失败返回nil
    public static func directorySize(at path: String) -> Int64? {
        guard let enumerator = FileManager.default.enumerator(atPath: path) else {
            return nil
        }
        
        var totalSize: Int64 = 0
        for file in enumerator {
            if let filePath = file as? String {
                let fullPath = (path as NSString).appendingPathComponent(filePath)
                if let size = fileSize(at: fullPath) {
                    totalSize += size
                }
            }
        }
        return totalSize
    }
    
    /// 获取目录内容列表
    /// - Parameter path: 目录路径
    /// - Returns: 文件列表，如果失败返回nil
    public static func contentsOfDirectory(at path: String) -> [String]? {
        return try? FileManager.default.contentsOfDirectory(atPath: path)
    }
}


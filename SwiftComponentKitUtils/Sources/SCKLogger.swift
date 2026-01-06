//
//  SCKLogger.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// 日志级别
public enum SCKLogLevel: Int {
    case debug = 0
    case info = 1
    case warning = 2
    case error = 3
    
    public var prefix: String {
        switch self {
        case .debug: return "🔵 [DEBUG]"
        case .info: return "🟢 [INFO]"
        case .warning: return "🟡 [WARNING]"
        case .error: return "🔴 [ERROR]"
        }
    }
}

/// 日志管理器
public class SCKLogger {
    /// 日志级别（默认debug，Release模式自动设为info）
    public static var logLevel: SCKLogLevel = {
        #if DEBUG
        return .debug
        #else
        return .info
        #endif
    }()
    
    /// 是否启用文件日志
    public static var enableFileLogging: Bool = false
    
    /// 日志文件路径
    public static var logFilePath: String? {
        didSet {
            if logFilePath != nil {
                enableFileLogging = true
            }
        }
    }
    
    /// Debug日志
    /// - Parameters:
    ///   - message: 日志消息
    ///   - file: 文件名（自动获取）
    ///   - line: 行号（自动获取）
    ///   - function: 函数名（自动获取）
    public static func debug(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(message, level: .debug, file: file, line: line, function: function)
    }
    
    /// Info日志
    public static func info(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(message, level: .info, file: file, line: line, function: function)
    }
    
    /// Warning日志
    public static func warning(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(message, level: .warning, file: file, line: line, function: function)
    }
    
    /// Error日志
    public static func error(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(message, level: .error, file: file, line: line, function: function)
    }
    
    // MARK: - Private Methods
    
    private static func log(_ message: String, level: SCKLogLevel, file: String, line: Int, function: String) {
        guard level.rawValue >= logLevel.rawValue else { return }
        
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "\(level.prefix) \(fileName):\(line) \(function) - \(message)"
        print(logMessage)
        
        if enableFileLogging {
            writeToFile(logMessage)
        }
        #endif
    }
    
    private static func writeToFile(_ message: String) {
        guard let path = logFilePath else { return }
        let fileURL = URL(fileURLWithPath: path)
        let logMessage = "\(Date()) \(message)\n"
        
        if let data = logMessage.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: path) {
                if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                }
            } else {
                // 创建目录
                let directory = (path as NSString).deletingLastPathComponent
                try? FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true)
                try? data.write(to: fileURL)
            }
        }
    }
}


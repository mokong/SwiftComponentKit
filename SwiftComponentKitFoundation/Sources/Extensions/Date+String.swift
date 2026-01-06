//
//  Date+String.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension Date {
    /// 将Date转换为指定格式的日期字符串
    /// - Parameter format: 日期格式字符串，例如："yyyy-MM-dd HH:mm:ss"
    /// - Returns: 格式化后的日期字符串
    public func sck_toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    /// 将Date转换为指定格式的日期字符串（UTC时区）
    public func sck_toStringUTC(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
    
    /// 从时间戳创建Date
    /// - Parameter timestamp: 时间戳（秒）
    /// - Returns: Date对象
    public static func sck_fromTimestamp(_ timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    /// 从时间戳（毫秒）创建Date
    /// - Parameter milliseconds: 时间戳（毫秒）
    /// - Returns: Date对象
    public static func sck_fromMilliseconds(_ milliseconds: Int64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }
}

extension Optional where Wrapped == Date {
    /// 将可选Date转换为指定格式的日期字符串
    /// - Parameter format: 日期格式字符串
    /// - Returns: 格式化后的日期字符串，如果Date为nil则返回nil
    public func sck_toString(format: String) -> String? {
        guard let date = self else {
            return nil
        }
        return date.sck_toString(format: format)
    }
    
    /// 将可选Date转换为指定格式的日期字符串（UTC时区）
    /// - Parameter format: 日期格式字符串
    /// - Returns: 格式化后的日期字符串（UTC时区），如果Date为nil则返回nil
    public func sck_toStringUTC(format: String) -> String? {
        guard let date = self else {
            return nil
        }
        return date.sck_toStringUTC(format: format)
    }
}


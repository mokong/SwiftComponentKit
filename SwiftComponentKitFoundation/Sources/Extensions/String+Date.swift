//
//  String+Date.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension String {
    /// 将字符串转换为Date
    /// - Parameter format: 日期格式字符串
    /// - Returns: Date对象，如果转换失败返回nil
    public func sck_toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
    
    /// 将字符串转换为Date（UTC时区）
    public func sck_toDateUTC(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: self)
    }
}


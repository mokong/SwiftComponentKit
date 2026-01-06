//
//  Int+Extension.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension Int {
    /// 格式化（千分位）
    public var sck_formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// 转字符串（带单位：K、M）
    public var sck_abbreviated: String {
        if self >= 1_000_000 {
            return String(format: "%.1fM", Double(self) / 1_000_000.0)
        } else if self >= 1_000 {
            return String(format: "%.1fK", Double(self) / 1_000.0)
        } else {
            return "\(self)"
        }
    }
    
    /// 转文件大小字符串
    public var sck_fileSizeString: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(self))
    }
}


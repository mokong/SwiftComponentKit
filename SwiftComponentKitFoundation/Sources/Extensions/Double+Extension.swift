//
//  Double+Extension.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension Double {
    /// 保留小数位
    /// - Parameter places: 小数位数
    /// - Returns: 保留小数位后的值
    public func sck_rounded(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// 格式化（保留小数位）
    /// - Parameter places: 小数位数
    /// - Returns: 格式化后的字符串
    public func sck_formatted(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    /// 转百分比字符串
    public var sck_percentageString: String {
        return String(format: "%.2f%%", self * 100)
    }
}


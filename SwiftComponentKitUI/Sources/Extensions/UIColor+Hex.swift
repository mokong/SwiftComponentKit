//
//  UIColor+Hex.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIColor {
    /// 从十六进制字符串创建颜色
    /// - Parameters:
    ///   - hexString: 十六进制字符串（支持格式：#FF2E2941、0xFF2E2941、FF2E2941、2E2941）
    ///   - alpha: 透明度（0-1），默认为 1.0
    /// - Returns: UIColor 对象
    public convenience init(sck_hexString hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 移除前缀
        if formatted.hasPrefix("0x") || formatted.hasPrefix("0X") {
            formatted = String(formatted[formatted.index(formatted.startIndex, offsetBy: 2)...])
        }
        if formatted.hasPrefix("#") {
            formatted = String(formatted[formatted.index(formatted.startIndex, offsetBy: 1)...])
        }
        
        // 转换为整数
        var hex: UInt32 = 0
        Scanner(string: formatted).scanHexInt32(&hex)
        
        // 根据字符串长度判断是否需要处理 ARGB 格式
        if formatted.count == 8 {
            // ARGB 格式：AARRGGBB
            let a = CGFloat((hex & 0xFF000000) >> 24) / 255.0
            let r = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
            let g = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
            let b = CGFloat(hex & 0x000000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a * alpha)
        } else if formatted.count == 6 {
            // RGB 格式：RRGGBB
            let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((hex & 0xFF00) >> 8) / 255.0
            let b = CGFloat(hex & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        } else {
            // 默认返回黑色
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
    
    /// 从十六进制整数值创建颜色
    /// - Parameters:
    ///   - hex: 十六进制整数值（例如：0xFF2E2941 或 0x2E2941）
    ///   - alpha: 透明度（0-1），默认为 1.0
    /// - Returns: UIColor 对象
    public convenience init(sck_hex hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 转换为十六进制字符串
    /// - Returns: 十六进制字符串（格式：RRGGBB）
    public func sck_toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        
        return String(format: "#%06x", rgb)
    }
}


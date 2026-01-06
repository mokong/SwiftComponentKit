//
//  UIFont+Extension.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIFont {
    /// 系统字体（便捷方法）
    /// - Parameter size: 字体大小
    /// - Returns: 系统字体
    public static func sck_systemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    /// 粗体系统字体
    /// - Parameter size: 字体大小
    /// - Returns: 粗体系统字体
    public static func sck_boldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    /// 中等粗细系统字体
    /// - Parameter size: 字体大小
    /// - Returns: 中等粗细系统字体
    @available(iOS 8.2, *)
    public static func sck_mediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    /// 细体系统字体
    /// - Parameter size: 字体大小
    /// - Returns: 细体系统字体
    @available(iOS 8.2, *)
    public static func sck_lightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    /// 超细体系统字体
    /// - Parameter size: 字体大小
    /// - Returns: 超细体系统字体
    @available(iOS 8.2, *)
    public static func sck_thinSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .thin)
    }
    
    /// 自定义字体（从Bundle）
    /// - Parameters:
    ///   - name: 字体名称
    ///   - size: 字体大小
    ///   - bundle: Bundle（默认main）
    /// - Returns: 字体，如果不存在返回系统字体
    public static func sck_customFont(
        name: String,
        size: CGFloat,
        bundle: Bundle = .main
    ) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    /// 缩放字体（根据屏幕尺寸）
    /// - Parameter size: 基准字体大小
    /// - Returns: 缩放后的字体大小
    public static func sck_scaledSize(_ size: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseWidth: CGFloat = 375 // iPhone 6/7/8 基准宽度
        let scale = screenWidth / baseWidth
        return size * min(scale, 1.2) // 最大缩放1.2倍
    }
    
    /// 缩放字体（返回字体）
    /// - Parameter size: 基准字体大小
    /// - Returns: 缩放后的字体
    public static func sck_scaledFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: sck_scaledSize(size))
    }
}


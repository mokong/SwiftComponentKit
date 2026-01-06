//
//  SCKTheme.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 主题协议
/// 在主工程中实现具体的主题定义
public protocol SCKTheme {
    /// 主色调
    var primaryColor: UIColor { get }
    
    /// 次要颜色
    var secondaryColor: UIColor { get }
    
    /// 背景色
    var backgroundColor: UIColor { get }
    
    /// 次要背景色
    var backgroundSecondaryColor: UIColor { get }
    
    /// 主文字颜色
    var textPrimaryColor: UIColor { get }
    
    /// 次要文字颜色
    var textSecondaryColor: UIColor { get }
    
    /// 第三级文字颜色
    var textTertiaryColor: UIColor { get }
    
    /// 强调色
    var accentColor: UIColor { get }
    
    /// 分割线颜色
    var separatorColor: UIColor { get }
    
    /// 错误颜色
    var errorColor: UIColor { get }
    
    /// 成功颜色
    var successColor: UIColor { get }
    
    /// 警告颜色
    var warningColor: UIColor { get }
}

/// 字体配置协议
/// 在主工程中实现具体的字体定义
public protocol SCKFontConfig {
    /// 标题字体
    var titleFont: UIFont { get }
    
    /// 大标题字体
    var largeTitleFont: UIFont { get }
    
    /// 副标题字体
    var subtitleFont: UIFont { get }
    
    /// 描述文字字体
    var descFont: UIFont { get }
    
    /// 按钮字体
    var buttonFont: UIFont { get }
    
    /// 小字体
    var smallFont: UIFont { get }
    
    /// 超小字体
    var tinyFont: UIFont { get }
}

/// 主题管理器
public class SCKThemeManager {
    public static let shared = SCKThemeManager()
    
    /// 当前主题（在主工程中设置）
    public var currentTheme: SCKTheme = SCKDefaultTheme.light {
        didSet {
            NotificationCenter.default.post(name: .sckThemeDidChange, object: currentTheme)
        }
    }
    
    /// 字体配置（在主工程中设置）
    public var fontConfig: SCKFontConfig?
    
    /// 切换主题
    /// - Parameter theme: 主题
    public func switchTheme(_ theme: SCKTheme) {
        currentTheme = theme
    }
    
    private init() {}
}

/// 主题变化通知
extension Notification.Name {
    public static let sckThemeDidChange = Notification.Name("SCKThemeDidChange")
}

/// 默认主题实现（示例，实际在主工程中实现）
public struct SCKDefaultTheme: SCKTheme {
    public static let light = SCKDefaultTheme(
        primaryColor: UIColor(sck_hexString: "#007AFF"),
        secondaryColor: UIColor(sck_hexString: "#5856D6"),
        backgroundColor: UIColor(sck_hexString: "#FFFFFF"),
        backgroundSecondaryColor: UIColor(sck_hexString: "#F2F2F7"),
        textPrimaryColor: UIColor(sck_hexString: "#000000"),
        textSecondaryColor: UIColor(sck_hexString: "#8E8E93"),
        textTertiaryColor: UIColor(sck_hexString: "#C7C7CC"),
        accentColor: UIColor(sck_hexString: "#007AFF"),
        separatorColor: UIColor(sck_hexString: "#C6C6C8"),
        errorColor: UIColor(sck_hexString: "#FF3B30"),
        successColor: UIColor(sck_hexString: "#34C759"),
        warningColor: UIColor(sck_hexString: "#FF9500")
    )
    
    public static let dark = SCKDefaultTheme(
        primaryColor: UIColor(sck_hexString: "#0A84FF"),
        secondaryColor: UIColor(sck_hexString: "#5E5CE6"),
        backgroundColor: UIColor(sck_hexString: "#000000"),
        backgroundSecondaryColor: UIColor(sck_hexString: "#1C1C1E"),
        textPrimaryColor: UIColor(sck_hexString: "#FFFFFF"),
        textSecondaryColor: UIColor(sck_hexString: "#8E8E93"),
        textTertiaryColor: UIColor(sck_hexString: "#636366"),
        accentColor: UIColor(sck_hexString: "#0A84FF"),
        separatorColor: UIColor(sck_hexString: "#38383A"),
        errorColor: UIColor(sck_hexString: "#FF453A"),
        successColor: UIColor(sck_hexString: "#32D74B"),
        warningColor: UIColor(sck_hexString: "#FF9F0A")
    )
    
    public let primaryColor: UIColor
    public let secondaryColor: UIColor
    public let backgroundColor: UIColor
    public let backgroundSecondaryColor: UIColor
    public let textPrimaryColor: UIColor
    public let textSecondaryColor: UIColor
    public let textTertiaryColor: UIColor
    public let accentColor: UIColor
    public let separatorColor: UIColor
    public let errorColor: UIColor
    public let successColor: UIColor
    public let warningColor: UIColor
    
    private init(
        primaryColor: UIColor,
        secondaryColor: UIColor,
        backgroundColor: UIColor,
        backgroundSecondaryColor: UIColor,
        textPrimaryColor: UIColor,
        textSecondaryColor: UIColor,
        textTertiaryColor: UIColor,
        accentColor: UIColor,
        separatorColor: UIColor,
        errorColor: UIColor,
        successColor: UIColor,
        warningColor: UIColor
    ) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.backgroundColor = backgroundColor
        self.backgroundSecondaryColor = backgroundSecondaryColor
        self.textPrimaryColor = textPrimaryColor
        self.textSecondaryColor = textSecondaryColor
        self.textTertiaryColor = textTertiaryColor
        self.accentColor = accentColor
        self.separatorColor = separatorColor
        self.errorColor = errorColor
        self.successColor = successColor
        self.warningColor = warningColor
    }
}

/// 默认字体配置（示例，实际在主工程中实现）
public struct SCKDefaultFontConfig: SCKFontConfig {
    public static let shared = SCKDefaultFontConfig()
    
    public var titleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 18)
    }
    
    public var largeTitleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 24)
    }
    
    public var subtitleFont: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    public var descFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    public var buttonFont: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    public var smallFont: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    public var tinyFont: UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    private init() {}
}


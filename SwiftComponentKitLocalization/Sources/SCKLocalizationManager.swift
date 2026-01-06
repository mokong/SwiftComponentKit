//
//  SCKLocalizationManager.swift
//  SwiftComponentKitLocalization
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// 本地化管理器
public class SCKLocalizationManager {
    public static let shared = SCKLocalizationManager()
    
    private var currentLanguage: String
    private var bundle: Bundle?
    
    private init() {
        // 从UserDefaults读取保存的语言
        // 注意：这里需要依赖SwiftComponentKitStorage，为了解耦，使用UserDefaults.standard
        currentLanguage = UserDefaults.standard.string(forKey: "SCK_CurrentLanguage") ?? "en"
        updateBundle()
    }
    
    /// 获取当前语言
    /// - Returns: 当前语言代码
    public func getCurrentLanguage() -> String {
        return currentLanguage
    }
    
    /// 设置语言
    /// - Parameter language: 语言代码（如：en, zh-Hans, ja等）
    public func setLanguage(_ language: String) {
        currentLanguage = language
        UserDefaults.standard.set(language, forKey: "SCK_CurrentLanguage")
        UserDefaults.standard.synchronize()
        updateBundle()
        
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name("SCKLanguageDidChange"), object: language)
    }
    
    /// 获取本地化字符串
    /// - Parameter key: 本地化key
    /// - Returns: 本地化字符串
    public func localizedString(forKey key: String) -> String {
        if let bundle = bundle {
            return bundle.localizedString(forKey: key, value: nil, table: nil)
        }
        return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
    
    /// 更新Bundle
    private func updateBundle() {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            self.bundle = nil
            return
        }
        self.bundle = bundle
    }
}

/// String扩展
extension String {
    /// 获取本地化字符串
    public var sck_localized: String {
        return SCKLocalizationManager.shared.localizedString(forKey: self)
    }
}


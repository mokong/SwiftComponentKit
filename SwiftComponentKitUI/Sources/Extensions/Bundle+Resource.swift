//
//  Bundle+Resource.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import UIKit

extension Bundle {
    /// 获取指定Bundle中的资源文件路径
    /// - Parameters:
    ///   - name: 资源文件名（不含扩展名）
    ///   - type: 资源文件类型（扩展名）
    ///   - bundleName: Bundle名称（可选，nil表示主Bundle）
    /// - Returns: 资源文件路径
    public static func sck_path(forResource name: String, ofType type: String, inBundle bundleName: String? = nil) -> String? {
        if let bundleName = bundleName, let bundle = Bundle(identifier: bundleName) {
            return bundle.path(forResource: name, ofType: type)
        }
        return Bundle.main.path(forResource: name, ofType: type)
    }
    
    /// 获取指定Bundle中的图片
    /// - Parameters:
    ///   - name: 图片名称
    ///   - bundleName: Bundle名称（可选，nil表示主Bundle）
    /// - Returns: UIImage对象
    public static func sck_image(named name: String, inBundle bundleName: String? = nil) -> UIImage? {
        if let bundleName = bundleName, let bundle = Bundle(identifier: bundleName) {
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return UIImage(named: name)
    }
    
    /// 获取指定Bundle中的本地化字符串
    /// - Parameters:
    ///   - key: 本地化key
    ///   - bundleName: Bundle名称（可选，nil表示主Bundle）
    /// - Returns: 本地化字符串
    public static func sck_localizedString(forKey key: String, inBundle bundleName: String? = nil) -> String {
        if let bundleName = bundleName, let bundle = Bundle(identifier: bundleName) {
            return bundle.localizedString(forKey: key, value: nil, table: nil)
        }
        return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
}


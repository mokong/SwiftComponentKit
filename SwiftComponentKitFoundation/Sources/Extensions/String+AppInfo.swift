//
//  String+AppInfo.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension String {
    /// 从Info.plist获取APP信息
    /// - Parameter key: Info.plist中的key
    /// - Returns: 对应的值，如果不存在返回nil
    public static func sck_appInfo(forKey key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
    
    /// 获取APP版本号
    public static var sck_appVersion: String {
        return sck_appInfo(forKey: "CFBundleShortVersionString") ?? ""
    }
    
    /// 获取APP构建版本号
    public static var sck_appBuildVersion: String {
        return sck_appInfo(forKey: "CFBundleVersion") ?? ""
    }
    
    /// 获取APP名称
    public static var sck_appName: String {
        return sck_appInfo(forKey: "CFBundleDisplayName") ?? sck_appInfo(forKey: "CFBundleName") ?? ""
    }
    
    /// 获取APP Bundle ID
    public static var sck_appBundleID: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
}


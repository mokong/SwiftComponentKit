//
//  SCKDeviceInfo.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import UIKit
import Foundation

/// 设备信息
public class SCKDeviceInfo {
    public static let shared = SCKDeviceInfo()
    
    private init() {}
    
    /// 设备型号
    public var model: String {
        return UIDevice.current.model
    }
    
    /// 设备名称
    public var name: String {
        return UIDevice.current.name
    }
    
    /// 系统名称
    public var systemName: String {
        return UIDevice.current.systemName
    }
    
    /// 系统版本
    public var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /// 设备标识符（UUID）
    public var identifierForVendor: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    /// 是否为iPhone
    public var isiPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /// 是否为iPad
    public var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// 是否为模拟器
    public var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    /// 屏幕宽度
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 屏幕高度
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 屏幕缩放比例
    public var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    
    /// 是否为全面屏（有刘海）
    public var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
                return false
            }
            return window.safeAreaInsets.top > 20
        }
        return false
    }
}


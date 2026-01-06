//
//  CGFloat+Screen.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension CGFloat {
    /// 屏幕宽度
    public static var sck_screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// 屏幕高度
    public static var sck_screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 状态栏高度
    public static var sck_statusBarHeight: CGFloat {
        if Thread.isMainThread {
            if #available(iOS 11.0, *) {
                guard let window = UIApplication.shared.delegate?.window ?? nil else {
                    return 20.0
                }
                return window.safeAreaInsets.top > 0 ? window.safeAreaInsets.top : 20.0
            } else {
                return UIApplication.shared.statusBarFrame.height
            }
        } else {
            var result: CGFloat = 20.0
            let semaphore = DispatchSemaphore(value: 0)
            DispatchQueue.main.async {
                if #available(iOS 11.0, *) {
                    guard let window = UIApplication.shared.delegate?.window ?? nil else {
                        result = 20.0
                        semaphore.signal()
                        return
                    }
                    result = window.safeAreaInsets.top > 0 ? window.safeAreaInsets.top : 20.0
                } else {
                    result = UIApplication.shared.statusBarFrame.height
                }
                semaphore.signal()
            }
            semaphore.wait()
            return result
        }
    }
    
    /// 导航栏高度
    public static var sck_navigationBarHeight: CGFloat {
        return sck_safeAreaTop + 64
    }
    
    /// TabBar高度
    public static var sck_tabBarHeight: CGFloat {
        return sck_safeAreaBottom + 49
    }
    
    /// 顶部安全区域高度
    public static var sck_safeAreaTop: CGFloat {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.delegate?.window ?? nil else {
                return 0.0
            }
            return window.safeAreaInsets.top - 20
        } else {
            return 0.0
        }
    }
    
    /// 底部安全区域高度
    public static var sck_safeAreaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.delegate?.window ?? nil else {
                return 0.0
            }
            return window.safeAreaInsets.bottom
        } else {
            return 0.0
        }
    }
    
    /// 获取安全区域信息
    public static var sck_safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.delegate?.window ?? nil else {
                return .zero
            }
            return window.safeAreaInsets
        } else {
            return .zero
        }
    }
}


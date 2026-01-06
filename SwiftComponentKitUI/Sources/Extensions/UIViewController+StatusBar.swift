//
//  UIViewController+StatusBar.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var statusBarHidden = "sck_statusBarHidden"
        static var statusBarStyle = "sck_statusBarStyle"
    }
    
    /// 状态栏是否隐藏
    public var sck_statusBarHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.statusBarHidden) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.statusBarHidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /// 状态栏样式
    public var sck_statusBarStyle: UIStatusBarStyle {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.statusBarStyle) as? UIStatusBarStyle ?? .default
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.statusBarStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /// 设置状态栏隐藏（带动画）
    /// - Parameters:
    ///   - hidden: 是否隐藏
    ///   - animated: 是否动画
    public func sck_setStatusBarHidden(_ hidden: Bool, animated: Bool) {
        sck_statusBarHidden = hidden
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}


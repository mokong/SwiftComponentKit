//
//  UIViewController+SwipeBack.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var swipeBackEnabled = "sck_swipeBackEnabled"
        static var swipeBackInterceptor = "sck_swipeBackInterceptor"
    }
    
    /// 侧滑返回是否启用
    public var sck_swipeBackEnabled: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.swipeBackEnabled) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.swipeBackEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            navigationController?.interactivePopGestureRecognizer?.isEnabled = newValue
            if newValue {
                setupSwipeBackGesture()
            }
        }
    }
    
    /// 侧滑返回拦截器（返回true表示允许返回，false表示阻止）
    public var sck_swipeBackInterceptor: (() -> Bool)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.swipeBackInterceptor) as? (() -> Bool)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.swipeBackInterceptor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setupSwipeBackGesture()
        }
    }
    
    /// 设置侧滑返回手势
    private func setupSwipeBackGesture() {
        guard let navigationController = navigationController else { return }
        navigationController.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - UIGestureRecognizerDelegate
extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 如果是侧滑返回手势
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            // 如果设置了拦截器，使用拦截器
            if let interceptor = sck_swipeBackInterceptor {
                return interceptor()
            }
            // 如果禁用了侧滑返回
            if !sck_swipeBackEnabled {
                return false
            }
            // 默认行为：如果只有一个ViewController，不允许返回
            return navigationController?.viewControllers.count ?? 0 > 1
        }
        return true
    }
}


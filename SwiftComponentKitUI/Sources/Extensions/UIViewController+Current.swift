//
//  UIViewController+Current.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIViewController {
    /// 获取当前显示的视图控制器
    /// - Returns: 当前视图控制器
    public static func sck_current() -> UIViewController? {
        guard let window = UIApplication.shared.delegate?.window,
              let rootViewController = window?.rootViewController else {
            return nil
        }
        return findBestViewController(rootViewController)
    }
    
    /// 获取当前导航控制器
    /// - Returns: 当前导航控制器
    public static func sck_currentNavigationController() -> UINavigationController? {
        return sck_current()?.navigationController
    }
    
    /// 获取当前Window
    /// - Returns: 当前Window
    public static func sck_currentWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    /// 递归查找最佳视图控制器
    private static func findBestViewController(_ viewController: UIViewController) -> UIViewController {
        if let presentedViewController = viewController.presentedViewController {
            return findBestViewController(presentedViewController)
        }
        
        if let splitViewController = viewController as? UISplitViewController {
            if let lastViewController = splitViewController.viewControllers.last {
                return findBestViewController(lastViewController)
            } else {
                return viewController
            }
        }
        
        if let navigationController = viewController as? UINavigationController {
            if let topViewController = navigationController.topViewController {
                return findBestViewController(topViewController)
            } else {
                return viewController
            }
        }
        
        if let tabBarController = viewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return findBestViewController(selectedViewController)
            } else {
                return viewController
            }
        }
        
        return viewController
    }
}


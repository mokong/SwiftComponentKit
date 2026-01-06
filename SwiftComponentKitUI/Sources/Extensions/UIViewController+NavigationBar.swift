//
//  UIViewController+NavigationBar.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIViewController {
    /// 导航栏是否隐藏
    public var sck_navigationBarHidden: Bool {
        get {
            return navigationController?.isNavigationBarHidden ?? false
        }
        set {
            navigationController?.setNavigationBarHidden(newValue, animated: true)
        }
    }
}


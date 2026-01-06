//
//  UIViewController+Keyboard.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var keyboardWillShowObserver = "sck_keyboardWillShowObserver"
        static var keyboardWillHideObserver = "sck_keyboardWillHideObserver"
    }
    
    /// 键盘显示回调
    public var sck_keyboardWillShow: ((CGRect) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.keyboardWillShowObserver) as? ((CGRect) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.keyboardWillShowObserver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 键盘隐藏回调
    public var sck_keyboardWillHide: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.keyboardWillHideObserver) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.keyboardWillHideObserver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 添加键盘监听
    public func sck_addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sck_keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sck_keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    /// 移除键盘监听
    public func sck_removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 点击空白处收起键盘
    public func sck_hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(sck_dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func sck_keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            sck_keyboardWillShow?(keyboardFrame)
        }
    }
    
    @objc private func sck_keyboardWillHide(_ notification: Notification) {
        sck_keyboardWillHide?()
    }
    
    @objc private func sck_dismissKeyboard() {
        view.endEditing(true)
    }
}


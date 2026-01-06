//
//  UIView+Gesture.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit
import ObjectiveC

extension UIView {
    private struct AssociatedKeys {
        static var tapGesture = "sck_tapGesture"
        static var longPressGesture = "sck_longPressGesture"
        static var swipeGesture = "sck_swipeGesture"
    }
    
    // MARK: - Tap Gesture
    
    /// 添加点击手势
    /// - Parameters:
    ///   - numberOfTaps: 点击次数（默认1）
    ///   - action: 点击回调
    /// - Returns: 手势识别器
    @discardableResult
    public func sck_addTapGesture(
        numberOfTaps: Int = 1,
        action: @escaping () -> Void
    ) -> UITapGestureRecognizer {
        // 移除旧的手势
        if let oldGesture = objc_getAssociatedObject(self, &AssociatedKeys.tapGesture) as? UITapGestureRecognizer {
            removeGestureRecognizer(oldGesture)
        }
        
        let gesture = UITapGestureRecognizer { [weak self] _ in
            action()
        }
        gesture.numberOfTapsRequired = numberOfTaps
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        
        objc_setAssociatedObject(self, &AssociatedKeys.tapGesture, gesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return gesture
    }
    
    /// 移除点击手势
    public func sck_removeTapGesture() {
        if let gesture = objc_getAssociatedObject(self, &AssociatedKeys.tapGesture) as? UITapGestureRecognizer {
            removeGestureRecognizer(gesture)
            objc_setAssociatedObject(self, &AssociatedKeys.tapGesture, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Long Press Gesture
    
    /// 添加长按手势
    /// - Parameters:
    ///   - minimumDuration: 最小持续时间（默认0.5秒）
    ///   - action: 长按回调
    /// - Returns: 手势识别器
    @discardableResult
    public func sck_addLongPressGesture(
        minimumDuration: TimeInterval = 0.5,
        action: @escaping () -> Void
    ) -> UILongPressGestureRecognizer {
        // 移除旧的手势
        if let oldGesture = objc_getAssociatedObject(self, &AssociatedKeys.longPressGesture) as? UILongPressGestureRecognizer {
            removeGestureRecognizer(oldGesture)
        }
        
        let gesture = UILongPressGestureRecognizer { [weak self] recognizer in
            if recognizer.state == .began {
                action()
            }
        }
        gesture.minimumPressDuration = minimumDuration
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        
        objc_setAssociatedObject(self, &AssociatedKeys.longPressGesture, gesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return gesture
    }
    
    /// 移除长按手势
    public func sck_removeLongPressGesture() {
        if let gesture = objc_getAssociatedObject(self, &AssociatedKeys.longPressGesture) as? UILongPressGestureRecognizer {
            removeGestureRecognizer(gesture)
            objc_setAssociatedObject(self, &AssociatedKeys.longPressGesture, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Swipe Gesture
    
    /// 添加滑动手势
    /// - Parameters:
    ///   - direction: 滑动方向
    ///   - action: 滑动回调
    /// - Returns: 手势识别器
    @discardableResult
    public func sck_addSwipeGesture(
        direction: UISwipeGestureRecognizer.Direction,
        action: @escaping () -> Void
    ) -> UISwipeGestureRecognizer {
        let gesture = UISwipeGestureRecognizer { [weak self] _ in
            action()
        }
        gesture.direction = direction
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        
        // 存储手势（支持多个方向）
        var gestures = objc_getAssociatedObject(self, &AssociatedKeys.swipeGesture) as? [UISwipeGestureRecognizer] ?? []
        gestures.append(gesture)
        objc_setAssociatedObject(self, &AssociatedKeys.swipeGesture, gestures, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return gesture
    }
    
    /// 移除滑动手势
    public func sck_removeSwipeGesture() {
        if let gestures = objc_getAssociatedObject(self, &AssociatedKeys.swipeGesture) as? [UISwipeGestureRecognizer] {
            gestures.forEach { removeGestureRecognizer($0) }
            objc_setAssociatedObject(self, &AssociatedKeys.swipeGesture, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - Gesture Recognizer Extension

extension UIGestureRecognizer {
    /// 便利初始化方法（支持闭包）
    convenience init(action: @escaping (UIGestureRecognizer) -> Void) {
        self.init()
        addTarget(ClosureWrapper(action: action), action: #selector(ClosureWrapper.invoke))
    }
}

private class ClosureWrapper: NSObject {
    let action: (UIGestureRecognizer) -> Void
    
    init(action: @escaping (UIGestureRecognizer) -> Void) {
        self.action = action
    }
    
    @objc func invoke(_ sender: UIGestureRecognizer) {
        action(sender)
    }
}


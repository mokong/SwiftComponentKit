//
//  UIView+Animation.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIView {
    /// 淡入动画
    /// - Parameters:
    ///   - duration: 动画时长（默认0.3秒）
    ///   - completion: 完成回调
    public func sck_fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
    
    /// 淡出动画
    /// - Parameters:
    ///   - duration: 动画时长（默认0.3秒）
    ///   - completion: 完成回调
    public func sck_fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.isHidden = true
            completion?()
        })
    }
    
    /// 缩放动画
    /// - Parameters:
    ///   - from: 起始缩放比例
    ///   - to: 目标缩放比例
    ///   - duration: 动画时长
    public func sck_scale(from: CGFloat, to: CGFloat, duration: TimeInterval) {
        transform = CGAffineTransform(scaleX: from, y: from)
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: to, y: to)
        }
    }
    
    /// 位移动画
    /// - Parameters:
    ///   - point: 目标位置
    ///   - duration: 动画时长
    public func sck_move(to point: CGPoint, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.center = point
        }
    }
    
    /// 旋转动画
    /// - Parameters:
    ///   - angle: 旋转角度（弧度）
    ///   - duration: 动画时长
    public func sck_rotate(angle: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    /// 弹性动画
    /// - Parameters:
    ///   - scale: 缩放比例
    ///   - duration: 动画时长
    ///   - damping: 阻尼系数（0-1，越小弹性越大）
    public func sck_springAnimation(scale: CGFloat, duration: TimeInterval, damping: CGFloat = 0.5) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
    /// 震动动画
    public func sck_shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10, 10, -10, 10, -5, 5, -2.5, 2.5, 0]
        layer.add(animation, forKey: "shake")
    }
}


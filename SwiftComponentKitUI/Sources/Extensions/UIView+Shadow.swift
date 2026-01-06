//
//  UIView+Shadow.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIView {
    /// 设置阴影
    /// - Parameters:
    ///   - color: 阴影颜色（默认黑色）
    ///   - opacity: 阴影透明度（0-1，默认0.5）
    ///   - offset: 阴影偏移（默认zero）
    ///   - radius: 阴影半径（默认5）
    public func sck_setShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize = .zero,
        radius: CGFloat = 5
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    /// 设置圆角（指定角）
    /// - Parameters:
    ///   - corners: 需要设置圆角的角
    ///   - radius: 圆角半径
    public func sck_roundCorners(
        corners: UIRectCorner,
        radius: CGFloat
    ) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


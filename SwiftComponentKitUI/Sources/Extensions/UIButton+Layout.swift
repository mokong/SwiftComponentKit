//
//  UIButton+Layout.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 按钮图片位置枚举
public enum SCKButtonImagePosition {
    case top          // 图片在上
    case bottom        // 图片在下
    case left          // 图片在左（默认）
    case right         // 图片在右
}

extension UIButton {
    /// 设置按钮图片和文字的位置
    /// - Parameters:
    ///   - position: 图片位置
    ///   - spacing: 图片和文字之间的间距
    public func sck_setImagePosition(_ position: SCKButtonImagePosition, spacing: CGFloat = 0) {
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        // 确保布局已完成
        layoutIfNeeded()
        
        let imageSize = imageView.frame.size
        let titleSize = titleLabel.frame.size
        
        var imageInsets = UIEdgeInsets.zero
        var titleInsets = UIEdgeInsets.zero
        
        switch position {
        case .top:
            imageInsets = UIEdgeInsets(top: -titleSize.height - spacing, left: 0, bottom: 0, right: -titleSize.width)
            titleInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - spacing, right: 0)
        case .bottom:
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -titleSize.height - spacing, right: -titleSize.width)
            titleInsets = UIEdgeInsets(top: -imageSize.height - spacing, left: -imageSize.width, bottom: 0, right: 0)
        case .left:
            imageInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: spacing / 2)
            titleInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
        case .right:
            imageInsets = UIEdgeInsets(top: 0, left: titleSize.width + spacing / 2, bottom: 0, right: -titleSize.width - spacing / 2)
            titleInsets = UIEdgeInsets(top: 0, left: -imageSize.width - spacing / 2, bottom: 0, right: imageSize.width + spacing / 2)
        }
        
        self.imageEdgeInsets = imageInsets
        self.titleEdgeInsets = titleInsets
    }
    
    /// 设置按钮图片大小
    /// - Parameter size: 图片大小
    public func sck_setImageSize(_ size: CGSize) {
        guard let imageView = imageView else { return }
        imageView.frame = CGRect(origin: imageView.frame.origin, size: size)
    }
}


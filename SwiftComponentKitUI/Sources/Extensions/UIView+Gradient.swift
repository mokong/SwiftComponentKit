//
//  UIView+Gradient.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 渐变方向枚举
public enum SCKGradientDirection {
    case horizontal          // 水平从左到右
    case vertical            // 垂直从上到下
    case diagonalTopLeft     // 对角线：左上到右下
    case diagonalTopRight    // 对角线：右上到左下
    case custom(start: CGPoint, end: CGPoint)  // 自定义方向
    
    var startPoint: CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 0, y: 0.5)
        case .vertical: return CGPoint(x: 0.5, y: 0)
        case .diagonalTopLeft: return CGPoint(x: 0, y: 0)
        case .diagonalTopRight: return CGPoint(x: 1, y: 0)
        case .custom(let start, _): return start
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 1, y: 0.5)
        case .vertical: return CGPoint(x: 0.5, y: 1)
        case .diagonalTopLeft: return CGPoint(x: 1, y: 1)
        case .diagonalTopRight: return CGPoint(x: 0, y: 1)
        case .custom(_, let end): return end
        }
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var gradientLayer = "sck_gradientLayer"
    }
    
    private var sck_gradientLayer: CAGradientLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.gradientLayer) as? CAGradientLayer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.gradientLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置渐变色背景
    /// - Parameters:
    ///   - colors: 渐变色数组（至少2个颜色）
    ///   - direction: 渐变方向（默认水平）
    ///   - locations: 渐变位置数组（可选，范围0.0-1.0）
    ///   - cornerRadius: 圆角半径（默认0）
    /// - Returns: 返回渐变图层，可用于后续操作
    @discardableResult
    public func sck_setGradientBackground(
        colors: [UIColor],
        direction: SCKGradientDirection = .horizontal,
        locations: [CGFloat]? = nil,
        cornerRadius: CGFloat = 0
    ) -> CAGradientLayer {
        // 移除旧的渐变层
        sck_gradientLayer?.removeFromSuperlayer()
        
        // 创建新的渐变层
        let layer = CAGradientLayer()
        layer.colors = colors.map { $0.cgColor }
        layer.startPoint = direction.startPoint
        layer.endPoint = direction.endPoint
        
        if let locations = locations {
            layer.locations = locations.map { NSNumber(value: Double($0)) }
        }
        
        layer.cornerRadius = cornerRadius
        layer.frame = bounds
        
        // 如果设置了圆角，需要同步视图的圆角
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
        
        // 确保视图背景透明，让渐变显示
        backgroundColor = .clear
        
        // 插入到最底层
        self.layer.insertSublayer(layer, at: 0)
        sck_gradientLayer = layer
        
        return layer
    }
    
    /// 更新渐变层的frame（在layoutSubviews中调用）
    public func sck_updateGradientFrame() {
        guard let gradientLayer = sck_gradientLayer else { return }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.frame = bounds
        CATransaction.commit()
    }
    
    /// 移除渐变背景
    public func sck_removeGradientBackground() {
        sck_gradientLayer?.removeFromSuperlayer()
        sck_gradientLayer = nil
    }
}


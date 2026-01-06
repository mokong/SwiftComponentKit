//
//  UIView+Divider.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIView {
    /// 添加顶部分割线
    /// - Parameters:
    ///   - color: 分割线颜色
    ///   - height: 分割线高度（默认0.5）
    ///   - leftMargin: 左边距（默认0）
    ///   - rightMargin: 右边距（默认0）
    /// - Returns: 分割线视图
    @discardableResult
    public func sck_addTopDivider(
        color: UIColor = UIColor.lightGray,
        height: CGFloat = 0.5,
        leftMargin: CGFloat = 0,
        rightMargin: CGFloat = 0
    ) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leftAnchor.constraint(equalTo: leftAnchor, constant: leftMargin),
            divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightMargin),
            divider.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return divider
    }
    
    /// 添加底部分割线
    @discardableResult
    public func sck_addBottomDivider(
        color: UIColor = UIColor.lightGray,
        height: CGFloat = 0.5,
        leftMargin: CGFloat = 0,
        rightMargin: CGFloat = 0
    ) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.leftAnchor.constraint(equalTo: leftAnchor, constant: leftMargin),
            divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightMargin),
            divider.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return divider
    }
    
    /// 添加左侧分割线
    @discardableResult
    public func sck_addLeftDivider(
        color: UIColor = UIColor.lightGray,
        width: CGFloat = 0.5,
        topMargin: CGFloat = 0,
        bottomMargin: CGFloat = 0
    ) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.leftAnchor.constraint(equalTo: leftAnchor),
            divider.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomMargin),
            divider.widthAnchor.constraint(equalToConstant: width)
        ])
        
        return divider
    }
    
    /// 添加右侧分割线
    @discardableResult
    public func sck_addRightDivider(
        color: UIColor = UIColor.lightGray,
        width: CGFloat = 0.5,
        topMargin: CGFloat = 0,
        bottomMargin: CGFloat = 0
    ) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.rightAnchor.constraint(equalTo: rightAnchor),
            divider.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomMargin),
            divider.widthAnchor.constraint(equalToConstant: width)
        ])
        
        return divider
    }
}


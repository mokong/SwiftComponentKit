//
//  UILabel+LineSpacing.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UILabel {
    /// 设置行间距
    /// - Parameters:
    ///   - lineSpacing: 行间距（点）
    ///   - text: 文本内容（可选，如果为nil则使用当前text）
    ///   - textColor: 文本颜色（可选，nil则使用当前textColor）
    public func sck_setLineSpacing(
        _ lineSpacing: CGFloat, 
        text: String? = nil,
        textColor: UIColor? = nil
    ) {
        if let text = text {
            self.text = text
        }
        
        guard let text = self.text, !text.isEmpty else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let finalTextColor = textColor ?? self.textColor ?? .black
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? UIFont.systemFont(ofSize: 17),
            .foregroundColor: finalTextColor,
            .paragraphStyle: paragraphStyle
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    /// 设置行高倍数
    /// - Parameters:
    ///   - multiple: 行高倍数（例如：1.5 表示行高是字体大小的1.5倍）
    ///   - text: 文本内容（可选）
    ///   - textColor: 文本颜色（可选，nil则使用当前textColor）
    public func sck_setLineHeightMultiple(
        _ multiple: CGFloat, 
        text: String? = nil,
        textColor: UIColor? = nil
    ) {
        if let text = text {
            self.text = text
        }
        
        guard let text = self.text, !text.isEmpty else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = multiple
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let finalTextColor = textColor ?? self.textColor ?? .black
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? UIFont.systemFont(ofSize: 17),
            .foregroundColor: finalTextColor,
            .paragraphStyle: paragraphStyle
        ]
        
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}


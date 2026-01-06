//
//  String+Processing.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import UIKit

extension String {
    /// 截取字符串（安全）
    /// - Parameters:
    ///   - from: 起始位置
    ///   - to: 结束位置
    /// - Returns: 截取后的字符串，如果范围无效返回nil
    public func sck_substring(from: Int, to: Int) -> String? {
        guard from >= 0 && to <= count && from <= to else { return nil }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
    
    /// 截取字符串（范围）
    /// - Parameter range: NSRange范围
    /// - Returns: 截取后的字符串
    public func sck_substring(range: NSRange) -> String? {
        guard let swiftRange = Range(range, in: self) else { return nil }
        return String(self[swiftRange])
    }
    
    /// 移除首尾空格
    public var sck_trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 移除所有空格
    public var sck_removingSpaces: String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    /// 首字母大写
    public var sck_capitalizedFirst: String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
    
    /// 计算字符串宽度
    /// - Parameter font: 字体
    /// - Returns: 字符串宽度
    public func sck_width(font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let rect = self.boundingRect(
            with: CGSize(width: 0, height: 20),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return rect.size.width
    }
    
    /// 计算字符串高度
    /// - Parameters:
    ///   - width: 最大宽度
    ///   - font: 字体
    /// - Returns: 字符串高度
    public func sck_height(width: CGFloat, font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let rect = self.boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return rect.size.height
    }
    
    /// Base64编码
    public var sck_base64Encoded: String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    /// Base64解码
    public var sck_base64Decoded: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// URL编码
    public var sck_urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// URL解码
    public var sck_urlDecoded: String? {
        return removingPercentEncoding
    }
}


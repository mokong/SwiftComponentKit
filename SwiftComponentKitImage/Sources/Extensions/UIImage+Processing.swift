//
//  UIImage+Processing.swift
//  SwiftComponentKitImage
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIImage {
    /// 缩放图片
    /// - Parameter size: 目标尺寸
    /// - Returns: 缩放后的图片
    public func sck_resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 裁剪图片
    /// - Parameter rect: 裁剪区域
    /// - Returns: 裁剪后的图片
    public func sck_crop(to rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
    }
    
    /// 圆角图片
    /// - Parameter radius: 圆角半径
    /// - Returns: 圆角图片
    public func sck_roundCorner(radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
        context?.clip()
        draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 压缩图片（质量压缩）
    /// - Parameter quality: 压缩质量（0.0-1.0）
    /// - Returns: 压缩后的Data
    public func sck_compress(quality: CGFloat) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    /// 压缩图片（尺寸压缩）
    /// - Parameter maxSize: 最大尺寸（宽或高的最大值）
    /// - Returns: 压缩后的图片
    public func sck_resize(maxSize: CGFloat) -> UIImage? {
        let ratio = min(maxSize / size.width, maxSize / size.height)
        guard ratio < 1.0 else { return self }
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        return sck_resize(to: newSize)
    }
    
    /// 添加水印
    /// - Parameters:
    ///   - text: 水印文字
    ///   - position: 水印位置
    ///   - attributes: 文字属性
    /// - Returns: 添加水印后的图片
    public func sck_addWatermark(text: String, position: CGPoint, attributes: [NSAttributedString.Key: Any]? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(at: .zero)
        
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.white.withAlphaComponent(0.7)
        ]
        
        let finalAttributes = attributes ?? defaultAttributes
        let attributedString = NSAttributedString(string: text, attributes: finalAttributes)
        attributedString.draw(at: position)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 生成二维码
    /// - Parameters:
    ///   - content: 二维码内容
    ///   - size: 二维码尺寸
    /// - Returns: 二维码图片
    public static func sck_generateQRCode(content: String, size: CGSize) -> UIImage? {
        guard let data = content.data(using: .utf8) else { return nil }
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let ciImage = filter?.outputImage else { return nil }
        
        let scaleX = size.width / ciImage.extent.size.width
        let scaleY = size.height / ciImage.extent.size.height
        let transformedImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        return UIImage(ciImage: transformedImage)
    }
    
    /// 生成条形码
    /// - Parameters:
    ///   - content: 条形码内容
    ///   - size: 条形码尺寸
    /// - Returns: 条形码图片
    public static func sck_generateBarcode(content: String, size: CGSize) -> UIImage? {
        guard let data = content.data(using: .ascii) else { return nil }
        
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        guard let ciImage = filter?.outputImage else { return nil }
        
        let scaleX = size.width / ciImage.extent.size.width
        let scaleY = size.height / ciImage.extent.size.height
        let transformedImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        return UIImage(ciImage: transformedImage)
    }
    
    /// 图片转Base64
    /// - Returns: Base64字符串
    public func sck_toBase64() -> String? {
        guard let imageData = pngData() else { return nil }
        return imageData.base64EncodedString()
    }
    
    /// Base64转图片
    /// - Parameter base64: Base64字符串
    /// - Returns: 图片对象
    public static func sck_fromBase64(_ base64: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64) else { return nil }
        return UIImage(data: data)
    }
}


//
//  UIImageView+Load.swift
//  SwiftComponentKitImage
//
//  Created by mokong on 2026/01/06.
//

import UIKit

extension UIImageView {
    /// 加载网络图片（带缓存）
    /// - Parameters:
    ///   - url: 图片URL
    ///   - placeholder: 占位图
    ///   - completion: 完成回调
    public func sck_loadImage(
        url: String,
        placeholder: UIImage? = nil,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        // 设置占位图
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        // 检查缓存
        if let cachedImage = SCKImageCache.shared.getImage(forKey: url) {
            self.image = cachedImage
            completion?(cachedImage)
            return
        }
        
        // 下载图片
        guard let imageURL = URL(string: url) else {
            completion?(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            // 缓存图片
            SCKImageCache.shared.setImage(image, forKey: url)
            
            DispatchQueue.main.async {
                self?.image = image
                completion?(image)
            }
        }.resume()
    }
    
    /// 加载网络图片（带进度）
    /// - Parameters:
    ///   - url: 图片URL
    ///   - progress: 进度回调
    ///   - completion: 完成回调
    public func sck_loadImage(
        url: String,
        progress: ((Double) -> Void)? = nil,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        guard let imageURL = URL(string: url) else {
            completion?(nil)
            return
        }
        
        // 检查缓存
        if let cachedImage = SCKImageCache.shared.getImage(forKey: url) {
            self.image = cachedImage
            completion?(cachedImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            // 缓存图片
            SCKImageCache.shared.setImage(image, forKey: url)
            
            DispatchQueue.main.async {
                self?.image = image
                completion?(image)
            }
        }
        
        task.resume()
    }
}

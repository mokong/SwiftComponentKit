//
//  SCKLoadingIndicator.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

public class SCKLoadingIndicator {
    private static var loadingView: UIView?
    
    /// 显示加载指示器
    /// - Parameters:
    ///   - view: 显示在哪个视图上（nil则显示在keyWindow上）
    ///   - message: 提示消息（可选）
    public static func show(in view: UIView? = nil, message: String? = nil) {
        hide()
        
        let containerView = view ?? UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let targetView = containerView else { return }
        
        let loadingView = UIView()
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.addSubview(indicator)
        targetView.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: targetView.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
            indicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        // 如果有消息，添加消息标签
        if let message = message, !message.isEmpty {
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.textColor = .white
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            messageLabel.textAlignment = .center
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            loadingView.addSubview(messageLabel)
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 16),
                messageLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
                messageLabel.leftAnchor.constraint(greaterThanOrEqualTo: loadingView.leftAnchor, constant: 20),
                messageLabel.rightAnchor.constraint(lessThanOrEqualTo: loadingView.rightAnchor, constant: -20)
            ])
        }
        
        self.loadingView = loadingView
        
        // 淡入动画
        loadingView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            loadingView.alpha = 1
        }
    }
    
    /// 隐藏加载指示器
    public static func hide() {
        guard let loadingView = loadingView else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            loadingView.alpha = 0
        }) { _ in
            loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
}


//
//  SCKToast.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

public class SCKToast {
    public enum Position {
        case top
        case center
        case bottom
    }
    
    public static func show(
        _ message: String,
        duration: TimeInterval = 2.0,
        position: Position = .center,
        in view: UIView? = nil
    ) {
        guard !message.isEmpty else { return }
        
        DispatchQueue.main.async {
            let targetView = view ?? UIApplication.shared.windows.first { $0.isKeyWindow }
            guard let containerView = targetView else { return }
            
            let toastView = SCKToastView(message: message)
            containerView.addSubview(toastView)
            
            // 使用AutoLayout布局
            toastView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toastView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                toastView.widthAnchor.constraint(lessThanOrEqualToConstant: containerView.bounds.width - 80)
            ])
            
            switch position {
            case .top:
                NSLayoutConstraint.activate([
                    toastView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 100)
                ])
            case .center:
                NSLayoutConstraint.activate([
                    toastView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
            case .bottom:
                NSLayoutConstraint.activate([
                    toastView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -100)
                ])
            }
            
            // 动画显示
            toastView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                toastView.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: duration, options: []) {
                    toastView.alpha = 0
                } completion: { _ in
                    toastView.removeFromSuperview()
                }
            }
        }
    }
}


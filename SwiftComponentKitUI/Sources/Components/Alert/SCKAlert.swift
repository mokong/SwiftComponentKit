//
//  SCKAlert.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

public class SCKAlert {
    public static func show(
        title: String? = nil,
        message: String?,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [SCKAlertAction] = [],
        from viewController: UIViewController? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alert.addAction(action.toUIAlertAction())
        }
        
        // 如果没有action，添加默认的确定按钮
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "确定", style: .default))
        }
        
        let presentingVC = viewController ?? UIViewController.sck_current()
        presentingVC?.present(alert, animated: true)
    }
}

public class SCKAlertAction {
    public let title: String
    public let style: UIAlertAction.Style
    public let handler: (() -> Void)?
    
    public init(title: String, style: UIAlertAction.Style = .default, handler: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    func toUIAlertAction() -> UIAlertAction {
        return UIAlertAction(title: title, style: style) { [weak self] _ in
            self?.handler?()
        }
    }
}


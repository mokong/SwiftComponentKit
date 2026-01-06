//
//  SCKPrivacyPolicyDialog.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 隐私政策弹窗
public class SCKPrivacyPolicyDialog {
    
    /// 配置信息
    public struct Configuration {
        public var title: String
        public var content: String
        public var termsTitle: String?
        public var termsURL: String?
        public var policyTitle: String?
        public var policyURL: String?
        public var agreeButtonTitle: String
        public var disagreeButtonTitle: String?
        public var style: Style
        
        public enum Style {
            case alert
            case sheet
        }
        
        public init(
            title: String = "隐私政策",
            content: String,
            termsTitle: String? = nil,
            termsURL: String? = nil,
            policyTitle: String? = nil,
            policyURL: String? = nil,
            agreeButtonTitle: String = "同意",
            disagreeButtonTitle: String? = "不同意",
            style: Style = .alert
        ) {
            self.title = title
            self.content = content
            self.termsTitle = termsTitle
            self.termsURL = termsURL
            self.policyTitle = policyTitle
            self.policyURL = policyURL
            self.agreeButtonTitle = agreeButtonTitle
            self.disagreeButtonTitle = disagreeButtonTitle
            self.style = style
        }
    }
    
    /// 显示隐私政策弹窗
    /// - Parameters:
    ///   - config: 配置信息
    ///   - onAgree: 同意回调
    ///   - onDisagree: 不同意回调（可选，如果为nil则不允许不同意）
    ///   - from: 从哪个ViewController显示（nil则自动查找）
    public static func show(
        config: Configuration,
        onAgree: @escaping () -> Void,
        onDisagree: (() -> Void)? = nil,
        from viewController: UIViewController? = nil
    ) {
        switch config.style {
        case .alert:
            showAlert(config: config, onAgree: onAgree, onDisagree: onDisagree, from: viewController)
        case .sheet:
            showSheet(config: config, onAgree: onAgree, onDisagree: onDisagree, from: viewController)
        }
    }
    
    /// 检查是否已同意隐私政策
    /// - Parameter key: 存储key（默认："SCK_PrivacyPolicyAgreed"）
    /// - Returns: 是否已同意
    public static func hasAgreed(key: String = "SCK_PrivacyPolicyAgreed") -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    /// 标记已同意隐私政策
    /// - Parameter key: 存储key（默认："SCK_PrivacyPolicyAgreed"）
    public static func markAsAgreed(key: String = "SCK_PrivacyPolicyAgreed") {
        UserDefaults.standard.set(true, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Private Methods
    
    private static func showAlert(
        config: Configuration,
        onAgree: @escaping () -> Void,
        onDisagree: (() -> Void)?,
        from viewController: UIViewController?
    ) {
        let alert = UIAlertController(title: config.title, message: config.content, preferredStyle: .alert)
        
        // 添加服务条款和隐私政策链接（如果提供）
        if let termsTitle = config.termsTitle, let termsURL = config.termsURL {
            let termsAction = UIAlertAction(title: termsTitle, style: .default) { _ in
                if let url = URL(string: termsURL) {
                    UIApplication.shared.open(url)
                }
            }
            alert.addAction(termsAction)
        }
        
        if let policyTitle = config.policyTitle, let policyURL = config.policyURL {
            let policyAction = UIAlertAction(title: policyTitle, style: .default) { _ in
                if let url = URL(string: policyURL) {
                    UIApplication.shared.open(url)
                }
            }
            alert.addAction(policyAction)
        }
        
        // 不同意按钮
        if let disagreeTitle = config.disagreeButtonTitle, let onDisagree = onDisagree {
            let disagreeAction = UIAlertAction(title: disagreeTitle, style: .cancel) { _ in
                onDisagree()
            }
            alert.addAction(disagreeAction)
        }
        
        // 同意按钮
        let agreeAction = UIAlertAction(title: config.agreeButtonTitle, style: .default) { _ in
            markAsAgreed()
            onAgree()
        }
        alert.addAction(agreeAction)
        
        let presentingVC = viewController ?? UIViewController.sck_current()
        presentingVC?.present(alert, animated: true)
    }
    
    private static func showSheet(
        config: Configuration,
        onAgree: @escaping () -> Void,
        onDisagree: (() -> Void)?,
        from viewController: UIViewController?
    ) {
        let alert = UIAlertController(title: config.title, message: config.content, preferredStyle: .actionSheet)
        
        // 添加服务条款和隐私政策链接
        if let termsTitle = config.termsTitle, let termsURL = config.termsURL {
            let termsAction = UIAlertAction(title: termsTitle, style: .default) { _ in
                if let url = URL(string: termsURL) {
                    UIApplication.shared.open(url)
                }
            }
            alert.addAction(termsAction)
        }
        
        if let policyTitle = config.policyTitle, let policyURL = config.policyURL {
            let policyAction = UIAlertAction(title: policyTitle, style: .default) { _ in
                if let url = URL(string: policyURL) {
                    UIApplication.shared.open(url)
                }
            }
            alert.addAction(policyAction)
        }
        
        // 同意按钮
        let agreeAction = UIAlertAction(title: config.agreeButtonTitle, style: .default) { _ in
            markAsAgreed()
            onAgree()
        }
        alert.addAction(agreeAction)
        
        // 不同意按钮
        if let disagreeTitle = config.disagreeButtonTitle, let onDisagree = onDisagree {
            let disagreeAction = UIAlertAction(title: disagreeTitle, style: .cancel) { _ in
                onDisagree()
            }
            alert.addAction(disagreeAction)
        }
        
        let presentingVC = viewController ?? UIViewController.sck_current()
        presentingVC?.present(alert, animated: true)
    }
}


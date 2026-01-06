//
//  SCKEmptyStateView.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

/// 空状态视图
public class SCKEmptyStateView: UIView {
    /// 配置
    public struct Configuration {
        public var image: UIImage?
        public var title: String?
        public var message: String?
        public var buttonTitle: String?
        public var buttonAction: (() -> Void)?
        
        public init(
            image: UIImage? = nil,
            title: String? = nil,
            message: String? = nil,
            buttonTitle: String? = nil,
            buttonAction: (() -> Void)? = nil
        ) {
            self.image = image
            self.title = title
            self.message = message
            self.buttonTitle = buttonTitle
            self.buttonAction = buttonAction
        }
    }
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    private var configuration: Configuration?
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .clear
        
        // 图片
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        // 标题
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // 消息
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        // 按钮
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        
        // 布局
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Public Methods
    
    /// 配置空状态视图
    /// - Parameter configuration: 配置
    public func configure(_ configuration: Configuration) {
        self.configuration = configuration
        
        imageView.image = configuration.image
        imageView.isHidden = configuration.image == nil
        
        titleLabel.text = configuration.title
        titleLabel.isHidden = configuration.title == nil
        
        messageLabel.text = configuration.message
        messageLabel.isHidden = configuration.message == nil
        
        actionButton.setTitle(configuration.buttonTitle, for: .normal)
        actionButton.isHidden = configuration.buttonTitle == nil
    }
    
    /// 显示在视图中
    /// - Parameters:
    ///   - view: 父视图
    ///   - configuration: 配置
    public static func show(in view: UIView, configuration: Configuration) -> SCKEmptyStateView {
        let emptyView = SCKEmptyStateView()
        emptyView.configure(configuration)
        view.addSubview(emptyView)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return emptyView
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        configuration?.buttonAction?()
    }
}


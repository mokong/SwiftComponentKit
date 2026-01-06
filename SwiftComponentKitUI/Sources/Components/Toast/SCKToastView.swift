//
//  SCKToastView.swift
//  SwiftComponentKitUI
//
//  Created by mokong on 2026/01/06.
//

import UIKit

class SCKToastView: UIView {
    private let messageLabel: UILabel
    
    init(message: String) {
        messageLabel = UILabel()
        super.init(frame: .zero)
        
        setupUI(message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(message: String) {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}


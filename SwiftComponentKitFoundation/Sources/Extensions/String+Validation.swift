//
//  String+Validation.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import UIKit

extension String {
    /// 验证邮箱
    public var sck_isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /// 验证手机号（中国）
    public var sck_isValidChinesePhone: Bool {
        let phoneRegex = "^1[3-9]\\d{9}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
    /// 验证手机号（通用，支持国际格式）
    public var sck_isValidPhone: Bool {
        let phoneRegex = "^[+]?[0-9]{1,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
    /// 验证URL
    public var sck_isValidURL: Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    /// 验证身份证号（中国）
    public var sck_isValidIDCard: Bool {
        let idCardRegex = "^[1-9]\\d{5}(18|19|20)\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{3}[0-9Xx]$"
        let idCardPredicate = NSPredicate(format: "SELF MATCHES %@", idCardRegex)
        return idCardPredicate.evaluate(with: self)
    }
    
    /// 验证密码强度
    public var sck_passwordStrength: SCKPasswordStrength {
        if count < 6 {
            return .weak
        }
        
        var hasLetter = false
        var hasNumber = false
        var hasSpecialChar = false
        
        for char in self {
            if char.isLetter {
                hasLetter = true
            } else if char.isNumber {
                hasNumber = true
            } else if "!@#$%^&*()_+-=[]{}|;:,.<>?".contains(char) {
                hasSpecialChar = true
            }
        }
        
        let strength = (hasLetter ? 1 : 0) + (hasNumber ? 1 : 0) + (hasSpecialChar ? 1 : 0)
        
        if strength >= 2 && count >= 8 {
            return .strong
        } else if strength >= 1 {
            return .medium
        } else {
            return .weak
        }
    }
    
    /// 验证是否为空（去除空格后）
    public var sck_isNotEmpty: Bool {
        return !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

/// 密码强度枚举
public enum SCKPasswordStrength {
    case weak
    case medium
    case strong
    
    public var description: String {
        switch self {
        case .weak: return "弱"
        case .medium: return "中"
        case .strong: return "强"
        }
    }
}


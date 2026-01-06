//
//  SCKCrypto.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import CommonCrypto

/// 加密工具
public class SCKCrypto {
    /// MD5加密
    /// - Parameter string: 要加密的字符串
    /// - Returns: MD5哈希值（32位十六进制字符串）
    public static func md5(_ string: String) -> String {
        let data = Data(string.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    /// SHA256加密
    /// - Parameter string: 要加密的字符串
    /// - Returns: SHA256哈希值（64位十六进制字符串）
    public static func sha256(_ string: String) -> String {
        let data = Data(string.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}


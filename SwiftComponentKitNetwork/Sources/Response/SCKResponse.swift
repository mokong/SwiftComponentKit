//
//  SCKResponse.swift
//  SwiftComponentKitNetwork
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import Alamofire

/// 通用响应协议
public protocol SCKResponseProtocol: Codable {
    /// 响应码
    var code: Int { get }
    
    /// 响应消息
    var message: String? { get }
    
    /// 是否成功
    var isSuccess: Bool { get }
}

/// 标准响应结构
/// 可根据项目实际情况调整字段名
public struct SCKStandardResponse<T: Codable>: SCKResponseProtocol {
    public let code: Int
    public let message: String?
    public let data: T?
    
    public var isSuccess: Bool {
        // 根据项目实际情况调整成功码
        return code == 200 || code == 0
    }
    
    // 支持不同的字段名映射
    enum CodingKeys: String, CodingKey {
        case code
        case message = "msg"  // 也可以映射为 "message"
        case data
    }
    
    public init(code: Int, message: String?, data: T?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

/// 空响应（用于不需要数据的请求）
public struct SCKEmptyResponse: SCKResponseProtocol {
    public let code: Int
    public let message: String?
    
    public var isSuccess: Bool {
        return code == 200 || code == 0
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case message = "msg"
    }
    
    public init(code: Int, message: String?) {
        self.code = code
        self.message = message
    }
}

/// 列表响应（常见的数据列表格式）
public struct SCKListResponse<T: Codable>: SCKResponseProtocol {
    public let code: Int
    public let message: String?
    public let data: [T]?
    public let total: Int?
    public let page: Int?
    public let pageSize: Int?
    
    public var isSuccess: Bool {
        return code == 200 || code == 0
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case message = "msg"
        case data
        case total
        case page
        case pageSize
    }
    
    public init(code: Int, message: String?, data: [T]?, total: Int? = nil, page: Int? = nil, pageSize: Int? = nil) {
        self.code = code
        self.message = message
        self.data = data
        self.total = total
        self.page = page
        self.pageSize = pageSize
    }
}

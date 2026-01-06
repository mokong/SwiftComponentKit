//
//  SCKResponseInterceptor.swift
//  SwiftComponentKitNetwork
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import Alamofire

/// 响应拦截器协议
public protocol SCKResponseInterceptorProtocol: AnyObject {
    /// 拦截响应（在返回前）
    /// - Parameters:
    ///   - data: 响应数据
    ///   - response: HTTP响应
    ///   - error: 错误（如果有）
    /// - Returns: 是否继续处理（true继续，false中断）
    func interceptResponse(
        data: Data?,
        response: HTTPURLResponse?,
        error: Error?
    ) -> Bool
}

/// 响应拦截器实现
public class SCKResponseInterceptor {
    private var interceptors: [SCKResponseInterceptorProtocol] = []
    
    public init(interceptors: [SCKResponseInterceptorProtocol] = []) {
        self.interceptors = interceptors
    }
    
    /// 添加拦截器
    /// - Parameter interceptor: 拦截器
    public func add(_ interceptor: SCKResponseInterceptorProtocol) {
        interceptors.append(interceptor)
    }
    
    /// 移除拦截器
    /// - Parameter interceptor: 拦截器
    public func remove(_ interceptor: SCKResponseInterceptorProtocol) {
        interceptors.removeAll { $0 === interceptor }
    }
    
    /// 执行拦截
    /// - Parameters:
    ///   - data: 响应数据
    ///   - response: HTTP响应
    ///   - error: 错误
    /// - Returns: 是否继续处理
    public func intercept(
        data: Data?,
        response: HTTPURLResponse?,
        error: Error?
    ) -> Bool {
        for interceptor in interceptors {
            if !interceptor.interceptResponse(data: data, response: response, error: error) {
                return false
            }
        }
        return true
    }
}


//
//  SCKRequestInterceptor.swift
//  SwiftComponentKitNetwork
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import Alamofire

/// 请求拦截器协议
public protocol SCKRequestInterceptorProtocol: AnyObject {
    /// 拦截请求（在发送前）
    /// - Parameters:
    ///   - url: 请求URL
    ///   - method: HTTP方法
    ///   - parameters: 请求参数
    ///   - headers: 请求头
    /// - Returns: 修改后的参数（可选）
    func interceptRequest(
        url: inout String,
        method: inout HTTPMethod,
        parameters: inout Parameters?,
        headers: inout HTTPHeaders?
    )
}

/// 请求拦截器实现
public class SCKRequestInterceptor: RequestInterceptor, SCKRequestInterceptorProtocol {
    private var interceptors: [SCKRequestInterceptorProtocol] = []
    
    public init(interceptors: [SCKRequestInterceptorProtocol] = []) {
        self.interceptors = interceptors
    }
    
    /// 添加拦截器
    /// - Parameter interceptor: 拦截器
    public func add(_ interceptor: SCKRequestInterceptorProtocol) {
        interceptors.append(interceptor)
    }
    
    /// 移除拦截器
    /// - Parameter interceptor: 拦截器
    public func remove(_ interceptor: SCKRequestInterceptorProtocol) {
        interceptors.removeAll { $0 === interceptor }
    }
    
    // MARK: - RequestInterceptor
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var url = urlRequest.url?.absoluteString ?? ""
        var method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET")
        var parameters: Parameters? = nil
        var headers: HTTPHeaders? = HTTPHeaders(urlRequest.allHTTPHeaderFields ?? [:])
        
        // 执行拦截器
        for interceptor in interceptors {
            interceptor.interceptRequest(
                url: &url,
                method: &method,
                parameters: &parameters,
                headers: &headers
            )
        }
        
        // 创建新的请求
        var request = urlRequest
        request.allHTTPHeaderFields = headers?.dictionary ?? [:]
        
        completion(.success(request))
    }
    
    // MARK: - SCKRequestInterceptorProtocol
    
    public func interceptRequest(
        url: inout String,
        method: inout HTTPMethod,
        parameters: inout Parameters?,
        headers: inout HTTPHeaders?
    ) {
        // 默认实现，子类可以重写
    }
}


//
//  SCKNetworkManager.swift
//  SwiftComponentKitNetwork
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import Alamofire
import Combine

/// 网络错误
public enum SCKNetworkError: Error {
    case alamofireError(AFError)
    case decodingError(Error)
    case unknown
    
    public var localizedDescription: String {
        switch self {
        case .alamofireError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .unknown:
            return "Unknown error"
        }
    }
}

/// 网络管理器
public class SCKNetworkManager {
    public static let shared = SCKNetworkManager()
    
    private let session: Session
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        configuration.timeoutIntervalForResource = 30.0
        
        session = Session(configuration: configuration)
    }
    
    /// 发起网络请求（使用Combine）
    /// - Parameters:
    ///   - url: 请求URL
    ///   - method: HTTP方法
    ///   - parameters: 请求参数
    ///   - headers: 请求头
    ///   - encoding: 参数编码方式
    /// - Returns: 返回Publisher，发布响应数据
    public func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) -> AnyPublisher<T, SCKNetworkError> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(.unknown))
                return
            }
            
            self.session.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: data)
                        promise(.success(result))
                    } catch {
                        promise(.failure(.decodingError(error)))
                    }
                case .failure(let error):
                    promise(.failure(.alamofireError(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// 发起网络请求（使用回调）
    /// - Parameters:
    ///   - url: 请求URL
    ///   - method: HTTP方法
    ///   - parameters: 请求参数
    ///   - headers: 请求头
    ///   - encoding: 参数编码方式
    ///   - completion: 完成回调
    /// - Returns: 可取消的请求
    @discardableResult
    public func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping (Result<T, SCKNetworkError>) -> Void
    ) -> DataRequest {
        return session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(.alamofireError(error)))
            }
        }
    }
}

/// 网络管理器扩展
extension SCKNetworkManager {
    /// 请求标准响应（带数据）
    /// - Parameters:
    ///   - url: 请求URL
    ///   - method: HTTP方法
    ///   - parameters: 请求参数
    ///   - headers: 请求头
    ///   - completion: 完成回调
    /// - Returns: 可取消的请求
    @discardableResult
    public func requestStandard<T: Codable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping (Result<SCKStandardResponse<T>, SCKNetworkError>) -> Void
    ) -> DataRequest {
        return request(url: url, method: method, parameters: parameters, headers: headers, encoding: encoding) {
            (result: Result<SCKStandardResponse<T>, SCKNetworkError>) in
            completion(result)
        }
    }
    
    /// 请求标准响应（空数据）
    @discardableResult
    public func requestStandard(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping (Result<SCKEmptyResponse, SCKNetworkError>) -> Void
    ) -> DataRequest {
        return request(url: url, method: method, parameters: parameters, headers: headers, encoding: encoding) {
            (result: Result<SCKEmptyResponse, SCKNetworkError>) in
            completion(result)
        }
    }
    
    /// 请求列表响应
    @discardableResult
    public func requestList<T: Codable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping (Result<SCKListResponse<T>, SCKNetworkError>) -> Void
    ) -> DataRequest {
        return request(url: url, method: method, parameters: parameters, headers: headers, encoding: encoding) {
            (result: Result<SCKListResponse<T>, SCKNetworkError>) in
            completion(result)
        }
    }
}


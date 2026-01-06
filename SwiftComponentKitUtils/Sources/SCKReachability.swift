//
//  SCKReachability.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import SystemConfiguration

/// 网络类型
public enum SCKNetworkType {
    case none
    case wifi
    case cellular
}

/// 网络状态检测
public class SCKReachability {
    public static let shared = SCKReachability()
    
    /// 是否连接网络
    public var isReachable: Bool {
        return networkType != .none
    }
    
    /// 网络类型
    public var networkType: SCKNetworkType {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .none
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .none
        }
        
        if !flags.contains(.reachable) {
            return .none
        }
        
        if flags.contains(.isWWAN) {
            return .cellular
        }
        
        return .wifi
    }
    
    /// 网络状态变化回调
    public var statusChanged: ((SCKNetworkType) -> Void)?
    
    private var reachability: SCNetworkReachability?
    
    private init() {
        setupReachability()
    }
    
    private func setupReachability() {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        reachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }
    }
}


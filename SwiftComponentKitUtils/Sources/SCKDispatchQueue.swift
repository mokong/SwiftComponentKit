//
//  SCKDispatchQueue.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// 多线程封装
public class SCKDispatchQueue {
    /// 主线程执行
    /// - Parameter block: 执行块
    public static func main(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    /// 后台线程执行
    /// - Parameter block: 执行块
    public static func background(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async(execute: block)
    }
    
    /// 延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - block: 执行块
    public static func after(_ delay: TimeInterval, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
    }
    
    /// 异步执行
    /// - Parameter block: 执行块
    public static func async(_ block: @escaping () -> Void) {
        DispatchQueue.global().async(execute: block)
    }
    
    /// 同步执行（主线程）
    /// - Parameter block: 执行块
    public static func sync(_ block: @escaping () -> Void) {
        DispatchQueue.main.sync(execute: block)
    }
}


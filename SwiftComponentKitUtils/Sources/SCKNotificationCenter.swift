//
//  SCKNotificationCenter.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// 通知中心封装
public class SCKNotificationCenter {
    private let notificationCenter = NotificationCenter.default
    private var observers: [NSObjectProtocol] = []
    
    public static let shared = SCKNotificationCenter()
    
    private init() {}
    
    /// 添加观察者
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 发送对象（可选）
    ///   - queue: 执行队列（默认主队列）
    ///   - block: 通知回调
    /// - Returns: 观察者token（可用于移除）
    @discardableResult
    public func addObserver(
        forName name: NSNotification.Name,
        object: Any? = nil,
        queue: OperationQueue? = .main,
        using block: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        let observer = notificationCenter.addObserver(
            forName: name,
            object: object,
            queue: queue,
            using: block
        )
        observers.append(observer)
        return observer
    }
    
    /// 移除观察者
    /// - Parameter observer: 观察者token
    public func removeObserver(_ observer: NSObjectProtocol) {
        notificationCenter.removeObserver(observer)
        observers.removeAll { $0 === observer }
    }
    
    /// 移除所有观察者
    public func removeAllObservers() {
        observers.forEach { notificationCenter.removeObserver($0) }
        observers.removeAll()
    }
    
    /// 发送通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 发送对象（可选）
    ///   - userInfo: 用户信息（可选）
    public func post(
        name: NSNotification.Name,
        object: Any? = nil,
        userInfo: [AnyHashable: Any]? = nil
    ) {
        notificationCenter.post(name: name, object: object, userInfo: userInfo)
    }
    
    deinit {
        removeAllObservers()
    }
}

// MARK: - 便捷扩展

extension SCKNotificationCenter {
    /// 添加观察者（使用字符串名称）
    /// - Parameters:
    ///   - name: 通知名称字符串
    ///   - object: 发送对象（可选）
    ///   - queue: 执行队列（默认主队列）
    ///   - block: 通知回调
    /// - Returns: 观察者token
    @discardableResult
    public func addObserver(
        forName name: String,
        object: Any? = nil,
        queue: OperationQueue? = .main,
        using block: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        return addObserver(
            forName: NSNotification.Name(name),
            object: object,
            queue: queue,
            using: block
        )
    }
    
    /// 发送通知（使用字符串名称）
    /// - Parameters:
    ///   - name: 通知名称字符串
    ///   - object: 发送对象（可选）
    ///   - userInfo: 用户信息（可选）
    public func post(
        name: String,
        object: Any? = nil,
        userInfo: [AnyHashable: Any]? = nil
    ) {
        post(name: NSNotification.Name(name), object: object, userInfo: userInfo)
    }
}


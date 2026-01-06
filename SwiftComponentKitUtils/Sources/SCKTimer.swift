//
//  SCKTimer.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// 定时器封装
public class SCKTimer {
    private var timer: Timer?
    private var block: (() -> Void)?
    
    /// 创建定时器
    /// - Parameters:
    ///   - interval: 时间间隔（秒）
    ///   - repeats: 是否重复
    ///   - block: 执行块
    /// - Returns: 定时器实例
    public static func scheduledTimer(
        interval: TimeInterval,
        repeats: Bool,
        block: @escaping () -> Void
    ) -> SCKTimer {
        let timer = SCKTimer()
        timer.block = block
        timer.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { _ in
            block()
        }
        return timer
    }
    
    /// 创建定时器（在主线程）
    /// - Parameters:
    ///   - interval: 时间间隔（秒）
    ///   - repeats: 是否重复
    ///   - block: 执行块
    /// - Returns: 定时器实例
    public static func scheduledTimerOnMainThread(
        interval: TimeInterval,
        repeats: Bool,
        block: @escaping () -> Void
    ) -> SCKTimer {
        let timer = SCKTimer()
        timer.block = block
        timer.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { _ in
            DispatchQueue.main.async {
                block()
            }
        }
        RunLoop.main.add(timer.timer!, forMode: .common)
        return timer
    }
    
    /// 停止定时器
    public func invalidate() {
        timer?.invalidate()
        timer = nil
        block = nil
    }
    
    deinit {
        invalidate()
    }
}

// MARK: - 延迟执行

extension SCKTimer {
    /// 延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - block: 执行块
    /// - Returns: 定时器实例（可用于取消）
    @discardableResult
    public static func after(
        _ delay: TimeInterval,
        block: @escaping () -> Void
    ) -> SCKTimer {
        return scheduledTimer(interval: delay, repeats: false, block: block)
    }
    
    /// 延迟执行（在主线程）
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - block: 执行块
    /// - Returns: 定时器实例（可用于取消）
    @discardableResult
    public static func afterOnMainThread(
        _ delay: TimeInterval,
        block: @escaping () -> Void
    ) -> SCKTimer {
        return scheduledTimerOnMainThread(interval: delay, repeats: false, block: block)
    }
}


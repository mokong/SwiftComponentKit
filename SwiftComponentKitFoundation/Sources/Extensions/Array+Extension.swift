//
//  Array+Extension.swift
//  SwiftComponentKitFoundation
//
//  Created by mokong on 2026/01/06.
//

import Foundation

extension Array {
    /// 安全访问（避免越界）
    /// - Parameter index: 索引
    /// - Returns: 元素，如果索引无效返回nil
    public func sck_safe(index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    /// 去重（Equatable）
    /// - Parameter keyPath: 用于去重的键路径
    /// - Returns: 去重后的数组
    public func sck_unique<T: Equatable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var seen: [T] = []
        return filter { element in
            let value = element[keyPath: keyPath]
            if seen.contains(value) {
                return false
            } else {
                seen.append(value)
                return true
            }
        }
    }
    
    /// 分组
    /// - Parameter keyPath: 用于分组的键路径
    /// - Returns: 分组后的字典
    public func sck_grouped<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        var grouped: [T: [Element]] = [:]
        for element in self {
            let key = element[keyPath: keyPath]
            if grouped[key] == nil {
                grouped[key] = []
            }
            grouped[key]?.append(element)
        }
        return grouped
    }
    
    /// 随机元素
    public var sck_random: Element? {
        guard !isEmpty else { return nil }
        return self[Int.random(in: 0..<count)]
    }
    
    /// 随机打乱
    public var sck_shuffled: [Element] {
        var array = self
        for i in stride(from: array.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            array.swapAt(i, j)
        }
        return array
    }
}


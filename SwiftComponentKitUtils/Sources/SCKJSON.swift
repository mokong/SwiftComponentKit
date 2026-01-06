//
//  SCKJSON.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation

/// JSON处理工具
public class SCKJSON {
    /// 将对象转换为JSON字符串
    /// - Parameter object: 要转换的对象（Dictionary、Array等）
    /// - Returns: JSON字符串，如果转换失败返回nil
    public static func stringify(_ object: Any) -> String? {
        guard JSONSerialization.isValidJSONObject(object) else {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    /// 将JSON字符串解析为对象
    /// - Parameter jsonString: JSON字符串
    /// - Returns: 解析后的对象（Dictionary或Array），如果解析失败返回nil
    public static func parse(_ jsonString: String) -> Any? {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
    
    /// 将JSON字符串解析为字典
    /// - Parameter jsonString: JSON字符串
    /// - Returns: 字典，如果解析失败返回nil
    public static func parseDictionary(_ jsonString: String) -> [String: Any]? {
        return parse(jsonString) as? [String: Any]
    }
    
    /// 将JSON字符串解析为数组
    /// - Parameter jsonString: JSON字符串
    /// - Returns: 数组，如果解析失败返回nil
    public static func parseArray(_ jsonString: String) -> [Any]? {
        return parse(jsonString) as? [Any]
    }
    
    /// 将对象编码为JSON Data
    /// - Parameter object: 要编码的对象
    /// - Returns: JSON Data，如果编码失败返回nil
    public static func encode(_ object: Any) -> Data? {
        guard JSONSerialization.isValidJSONObject(object) else {
            return nil
        }
        
        return try? JSONSerialization.data(withJSONObject: object, options: [])
    }
    
    /// 将JSON Data解码为对象
    /// - Parameter data: JSON Data
    /// - Returns: 解码后的对象，如果解码失败返回nil
    public static func decode(_ data: Data) -> Any? {
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
    
    /// 将Codable对象编码为JSON字符串
    /// - Parameter object: Codable对象
    /// - Returns: JSON字符串，如果编码失败返回nil
    public static func encode<T: Encodable>(_ object: T) -> String? {
        guard let data = try? JSONEncoder().encode(object) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /// 将JSON字符串解码为Codable对象
    /// - Parameters:
    ///   - jsonString: JSON字符串
    ///   - type: 目标类型
    /// - Returns: 解码后的对象，如果解码失败返回nil
    public static func decode<T: Decodable>(_ jsonString: String, as type: T.Type) -> T? {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(type, from: data)
    }
}


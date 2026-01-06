//
//  SCKPermissionManager.swift
//  SwiftComponentKitUtils
//
//  Created by mokong on 2026/01/06.
//

import Foundation
import AVFoundation
import Photos
import CoreLocation
import UserNotifications
import Contacts
import EventKit
import UIKit

/// 权限类型
public enum SCKPermissionType {
    case camera
    case microphone
    case photoLibrary
    case location
    case locationAlways  // 始终定位
    case notification
    case contacts
    case calendar
    case reminders
}

/// 权限状态
public enum SCKPermissionStatus {
    case notDetermined    // 未决定
    case authorized       // 已授权
    case denied          // 已拒绝
    case restricted      // 受限
    
    public var isAuthorized: Bool {
        return self == .authorized
    }
}

/// 权限管理器
public class SCKPermissionManager {
    /// 检查权限状态
    /// - Parameter type: 权限类型
    /// - Returns: 权限状态
    public static func checkPermissionStatus(_ type: SCKPermissionType) -> SCKPermissionStatus {
        switch type {
        case .camera:
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            return mapAVAuthorizationStatus(status)
        case .microphone:
            let status = AVCaptureDevice.authorizationStatus(for: .audio)
            return mapAVAuthorizationStatus(status)
        case .photoLibrary:
            let status = PHPhotoLibrary.authorizationStatus()
            return mapPHAuthorizationStatus(status)
        case .location:
            let status = CLLocationManager.authorizationStatus()
            return mapCLAuthorizationStatus(status)
        case .locationAlways:
            let status = CLLocationManager.authorizationStatus()
            return mapCLAuthorizationStatus(status)
        case .notification:
            // 需要异步检查
            return .notDetermined
        case .contacts:
            let status = CNContactStore.authorizationStatus(for: .contacts)
            return mapCNAuthorizationStatus(status)
        case .calendar:
            let status = EKEventStore.authorizationStatus(for: .event)
            return mapEKAuthorizationStatus(status)
        case .reminders:
            let status = EKEventStore.authorizationStatus(for: .reminder)
            return mapEKAuthorizationStatus(status)
        }
    }
    
    /// 请求权限
    /// - Parameters:
    ///   - type: 权限类型
    ///   - completion: 完成回调
    public static func requestPermission(
        _ type: SCKPermissionType,
        completion: @escaping (SCKPermissionStatus) -> Void
    ) {
        switch type {
        case .camera:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        case .microphone:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        case .photoLibrary:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(self.mapPHAuthorizationStatus(status))
                }
            }
        case .location, .locationAlways:
            // 需要CLLocationManager实例，这里返回notDetermined
            // 实际使用时需要创建CLLocationManager并设置delegate
            completion(.notDetermined)
        case .notification:
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        case .contacts:
            CNContactStore().requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        case .calendar:
            EKEventStore().requestAccess(to: .event) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        case .reminders:
            EKEventStore().requestAccess(to: .reminder) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        }
    }
    
    /// 打开系统设置页面
    public static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Private Helpers
    
    private static func mapAVAuthorizationStatus(_ status: AVAuthorizationStatus) -> SCKPermissionStatus {
        switch status {
        case .notDetermined: return .notDetermined
        case .authorized: return .authorized
        case .denied: return .denied
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private static func mapPHAuthorizationStatus(_ status: PHAuthorizationStatus) -> SCKPermissionStatus {
        switch status {
        case .notDetermined: return .notDetermined
        case .authorized, .limited: return .authorized
        case .denied: return .denied
        case .restricted: return .restricted
        @unknown default: return .notDetermined
        }
    }
    
    private static func mapCLAuthorizationStatus(_ status: CLAuthorizationStatus) -> SCKPermissionStatus {
        switch status {
        case .notDetermined: return .notDetermined
        case .authorizedWhenInUse, .authorizedAlways: return .authorized
        case .denied, .restricted: return .denied
        @unknown default: return .notDetermined
        }
    }
    
    private static func mapCNAuthorizationStatus(_ status: CNAuthorizationStatus) -> SCKPermissionStatus {
        switch status {
        case .notDetermined: return .notDetermined
        case .authorized: return .authorized
        case .denied, .restricted: return .denied
        @unknown default: return .notDetermined
        }
    }
    
    private static func mapEKAuthorizationStatus(_ status: EKAuthorizationStatus) -> SCKPermissionStatus {
        switch status {
        case .notDetermined: return .notDetermined
        case .authorized: return .authorized
        case .denied, .restricted: return .denied
        @unknown default: return .notDetermined
        }
    }
}


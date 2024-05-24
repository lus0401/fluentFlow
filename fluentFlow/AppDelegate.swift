//
//  AppDelegate.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import Foundation
import SwiftUI
import UIKit

import FirebaseCore
import KakaoSDKAuth

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    // 앱 시작 시 초기 설정
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase 초기화
        FirebaseApp.configure()
        return true
    }
    
    // URL 핸들링
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}


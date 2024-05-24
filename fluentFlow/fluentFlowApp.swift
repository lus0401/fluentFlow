//
//  fluentFlowApp.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore

@main
struct fluentFlowApp: App {

    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        if let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String {
            print("kakaoAppKey: \(kakaoAppKey)")
            // Kakao SDK 초기화
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        } else {
            print("Kakao 앱 키를 찾을 수 없습니다.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            //LoginView(viewModel: LoginViewModel())
            LoginView().onOpenURL(perform: { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}


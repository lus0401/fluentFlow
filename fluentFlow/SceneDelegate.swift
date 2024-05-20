////
////  SceneDelegate.swift
////  fluentFlow
////
////  Created by Lee HyeKyung on 5/17/24.
////
//
//import Foundation
//import UIKit
//import KakaoSDKAuth
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        if let url = URLContexts.first?.url {
//            if (AuthApi.isKakaoTalkLoginUrl(url)) {
//                _ = AuthController.handleOpenUrl(url: url)
//            }
//        }
//    }
//}

//import UIKit
//import SwiftUI
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        let window = UIWindow(windowScene: windowScene)
//        let mainView = LoginView() // 루트 뷰 설정
//
//        window.rootViewController = UIHostingController(rootView: mainView)
//        self.window = window
//        window.makeKeyAndVisible()
//    }
//}

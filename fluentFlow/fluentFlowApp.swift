//
//  fluentFlowApp.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI
import KakaoSDKCommon

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    KakaoSDK.initSDK(appKey: "${NATIVE_APP_KEY}")

}

@main
struct fluentFlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  LoginViewModel.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel: ObservableObject {

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var autoLogin: Bool = false
    @Published var isLoggedIn : Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor 
    func kakaoLogout() {
        Task{
            if await handleKakaoLogout() {
                isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleKakaoAppLogin() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleKakaoAccountLogin() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func handleKakaoLogin() {
        Task{
            // 카카오톡 실행 가능 여부 확인 - 설치 되어있는 경우
            if (UserApi.isKakaoTalkLoginAvailable()) {
                isLoggedIn = await handleKakaoAppLogin()

            } else { //설치 안된 경우
                isLoggedIn = await handleKakaoAccountLogin()
            }
        }
    }
    
    func login() {
        // 로그인 로직 구현
        print("로그인 시도: \(id), \(password), 자동 로그인: \(autoLogin)")
    }
    
    func findId() {
        // 아이디 찾기 로직 구현
        print("아이디 찾기")
    }
    
    func findPassword() {
        // 비밀번호 찾기 로직 구현
        print("비밀번호 찾기")
    }
    
    func signUp() {
        // 회원가입 로직 구현
        print("회원가입")
    }
    
    func kakaoLogin() {
        // 카카오 로그인 로직 구현
        print("카카오 로그인")
    }

}

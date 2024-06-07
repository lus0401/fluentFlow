import SwiftUI
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewModel: ObservableObject {

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var autoLogin: Bool = false
    @Published var isLoggedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var loginStatusInfo: (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 성능: ON" : "로그인 성능: OFF"
    }
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout { error in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleKakaoAppLogin() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleKakaoAccountLogin() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                } else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func handleKakaoLogin() {
        Task {
            if UserApi.isKakaoTalkLoginAvailable() {
                isLoggedIn = await handleKakaoAppLogin()
                if isLoggedIn {
                    // Fetch user info and update ProfileViewModel
                    UserApi.shared.me { user, error in
                        if let error = error {
                            print(error)
                        } else {
                            if let user = user {
                                ProfileViewModel().updateUserInformation(username: user.kakaoAccount?.profile?.nickname ?? "", email: user.kakaoAccount?.email ?? "")
                            }
                        }
                    }
                }
            } else {
                isLoggedIn = await handleKakaoAccountLogin()
                if isLoggedIn {
                    // Fetch user info and update ProfileViewModel
                    UserApi.shared.me { user, error in
                        if let error = error {
                            print(error)
                        } else {
                            if let user = user {
                                ProfileViewModel().updateUserInformation(username: user.kakaoAccount?.profile?.nickname ?? "", email: user.kakaoAccount?.email ?? "")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func login() {
        print("로그인 시도: \(id), \(password), 자동 로그인: \(autoLogin)")
        isLoggedIn = true
        // Update ProfileViewModel with login details
        ProfileViewModel().updateUserInformation(username: id, email: "\(id)@example.com")
    }
    
    func findId() {
        print("아이디 찾기")
    }
    
    func findPassword() {
        print("비밀번호 찾기")
    }
}

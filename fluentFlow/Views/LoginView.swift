//
//  LoginView.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    let loginStatusInfo: (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 성능: ON" : "로그인 성능: OFF"
    }
    
    var body: some View {
        Text(loginStatusInfo(viewModel.isLoggedIn))
        
        VStack {
            Spacer()
            
            // 아이디 입력 필드
            TextField("아이디", text: $viewModel.id)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.horizontal, 20)
            
            // 비밀번호 입력 필드
            SecureField("비밀번호", text: $viewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.horizontal, 20)
            
            // 자동 로그인 체크박스
            Toggle(isOn: $viewModel.autoLogin) {
                Text("자동 로그인")
            }
            .padding(.horizontal, 20)
            
            // 로그인 버튼
            Button(action: {
                viewModel.login()
            }) {
                Text("로그인")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20)
            
            // 하단 링크들
            HStack {
                Button(action: {
                    viewModel.findId()
                }) {
                    Text("아이디 찾기")
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.findPassword()
                }) {
                    Text("비밀번호 찾기")
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.signUp()
                }) {
                    Text("회원가입")
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Apple Login Button
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.email, .fullName]
                
            } onCompletion: { result in
                switch result {
                case .success(let auth):
                    switch auth.credential{
                    case let credential as ASAuthorizationAppleIDCredential:
                        // User Id
                        let userID = credential.user
                        
                        // User Info
                        let email = credential.email
                        let firstName = credential.fullName?.givenName
                        let lasttName = credential.fullName?.familyName
                        
                        
                        self.userId = userID
                        
                        self.email = email ?? ""
                        self.firstName = firstName ?? ""
                        self.lastName = lasttName ?? ""
                        
                        
                        break
                        
                    default :
                        break
                    }
                    
                    break
                case .failure(let error):
                    break
                }
                
            }
            .signInWithAppleButtonStyle(
                colorScheme == .dark ? .white : .black
            )
            .frame(height: 50)
            .padding()
            .cornerRadius(8)
            
            // 카카오 로그인 버튼
            Button(action: {
                viewModel.handleKakaoLogin()
            }) {
                HStack {
                    Image(systemName: "message.fill")
                    Text("카카오 로그인")
                }
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                .cornerRadius(8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Button(action: {
                viewModel.kakaoLogout()
            }) {
                Text("로그아웃")
            }
            
            Spacer()
        }
        .navigationBarTitle("로그인")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}

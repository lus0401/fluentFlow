import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""

    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @State private var showSignUp = false
    @State private var isLoggedIn = false
    @StateObject var userSettings = UserSettings()

    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.loginStatusInfo(viewModel.isLoggedIn))
                
                Spacer()
                
                TextField("아이디", text: $viewModel.id)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                SecureField("비밀번호", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                
                Toggle(isOn: $viewModel.autoLogin) {
                    Text("자동 로그인")
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    viewModel.login()
                    if viewModel.isLoggedIn {
                        isLoggedIn = true
                    }
                }) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(5.0)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Button(action: viewModel.findId) {
                        Text("아이디 찾기")
                    }
                    
                    Spacer()
                    
                    Button(action: viewModel.findPassword) {
                        Text("비밀번호 찾기")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showSignUp = true
                    }) {
                        Text("회원가입")
                    }
                    .sheet(isPresented: $showSignUp) {
                        SignUpView()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                    case .success(let auth):
                        switch auth.credential {
                        case let credential as ASAuthorizationAppleIDCredential:
                            self.userId = credential.user
                            self.email = credential.email ?? ""
                            self.firstName = credential.fullName?.givenName ?? ""
                            self.lastName = credential.fullName?.familyName ?? ""
                            viewModel.isLoggedIn = true
                            isLoggedIn = true
                            ProfileViewModel().updateUserInformation(username: "\(self.firstName) \(self.lastName)", email: self.email)
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(height: 50)
                .padding()
                .cornerRadius(8)
                
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
                
                Button(action: viewModel.kakaoLogout) {
                    Text("로그아웃")
                }
                
                Spacer()
                
                NavigationLink(destination: destinationView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .navigationBarTitle("로그인")
            .onChange(of: viewModel.isLoggedIn) { newValue in
                isLoggedIn = newValue
            }
        }
        .environmentObject(userSettings)
    }

    @ViewBuilder
    private func destinationView() -> some View {
        if userSettings.selectedEnglishLevel == nil {
            EnglishLevelView(isLoggedIn: $isLoggedIn)
        } else if userSettings.selectedPurposes.isEmpty {
            PurposesView()
        } else {
            ChatPracticeView()
        }
    }
}

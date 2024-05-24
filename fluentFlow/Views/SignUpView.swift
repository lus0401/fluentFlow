import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("회원가입")
                .font(.largeTitle)
                .padding()

            TextField("이메일", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("비밀번호", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("이름", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: signUp) {
                Text("회원가입")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }

    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("회원가입 실패: \(error.localizedDescription)")
                    errorMessage = "회원가입 실패: \(error.localizedDescription)"
                    return
                }

                guard let uid = authResult?.user.uid else { return }
                let db = Firestore.firestore()
                db.collection("users").document(uid).setData([
                    "email": email,
                    "name": name
                ]) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("사용자 정보 저장 실패: \(error.localizedDescription)")
                            errorMessage = "사용자 정보 저장 실패: \(error.localizedDescription)"
                        } else {
                            errorMessage = "회원가입 성공!"
                        }
                    }
                }
            }
        }
    }
}

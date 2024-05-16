//
//  LoginViewModel.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showingAlert: Bool = false

    func login() {
        if username.isEmpty || password.isEmpty {
            showingAlert = true
        } else {
            // 실제 로그인 로직 추가
            print("Login successful")
        }
    }
}

//
//  ProfileViewModel.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User?

    init() {
        // 임시 유저 데이터 로드
        self.user = User(username: "JohnDoe", email: "john.doe@example.com")
    }
}

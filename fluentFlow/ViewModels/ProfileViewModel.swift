import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User?

    init() {
        // 임시 유저 데이터 로드
        self.user = User(username: "", email: "")
    }
    
    func updateUserInformation(username: String, email: String) {
        self.user = User(username: username, email: email)
    }
}

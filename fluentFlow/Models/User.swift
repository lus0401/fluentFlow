//
//  User.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import Foundation

struct User: Identifiable {
    var id: UUID = UUID()
    var password: String
    var username: String
    var nickname: String
    var profileImage: String
    var email: String
    
}


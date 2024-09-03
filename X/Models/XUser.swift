//
//  XUser.swift
//  X
//
//  Created by Mabast on 2024-08-19.
//

import Foundation
import Firebase
import FirebaseAuth

struct XUser: Codable {
    let id: String
    var displayName: String = ""
    var username: String = ""
    var followers: Int = 0
    var following: Int = 0
    var createOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboard: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
    
}

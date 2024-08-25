//
//  ProfileDataFormViewModel.swift
//  X
//
//  Created by Mabast on 2024-08-20.
//

import Foundation
import Combine
import UIKit

final class ProfileDataFormViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var image: UIImage?
    @Published var isFormValid: Bool = false
    
    
    func validateForm() {
        guard let _ = displayName,
              let username = username, username.count > 2,
              let bio = bio, bio.count > 2, image != nil else {
            return isFormValid = false
        }
        isFormValid = true
    }
    
}

//
//  ProfileDataFormViewModel.swift
//  X
//
//  Created by Mabast on 2024-08-20.
//

import Foundation
import Combine

final class ProfileDataFormViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    
}

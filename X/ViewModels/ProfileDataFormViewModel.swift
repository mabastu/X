//
//  ProfileDataFormViewModel.swift
//  X
//
//  Created by Mabast on 2024-08-20.
//

import Foundation
import Combine
import UIKit
import FirebaseAuth
import FirebaseStorage

final class ProfileDataFormViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var image: UIImage?
    @Published var isFormValid: Bool = false
    @Published var error: String = ""
    @Published var url: URL?
    
    private var subscription: Set<AnyCancellable>  = []
    
    func validateForm() {
        guard let _ = displayName,
              let username = username, username.count > 2,
              let bio = bio, bio.count > 2, image != nil else {
            return isFormValid = false
        }
        isFormValid = true
    }
    
    func uploadAvatarImage() {
        let randomID = UUID().uuidString
        guard let image = image?.jpegData(compressionQuality: 0.5) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "images/jpeg"
        StorageManager.shared.uploadProfilePhoto(with: randomID, image: image, metaData: metaData)
            .flatMap({ metadata in
                StorageManager.shared.getDownloadURL(for: metadata.path)
            })
            .sink { [weak self] completion in
                if case.failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                self?.url = url
            }
            .store(in: &subscription)
    }
    
}

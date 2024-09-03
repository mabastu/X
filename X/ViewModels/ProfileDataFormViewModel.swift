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
    @Published var isOnboardingFinished: Bool = false
    
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
        metaData.contentType = "images/jpg"
        StorageManager.shared.uploadProfilePhoto(with: randomID, image: image, metaData: metaData)
            .flatMap({ metadata in
                StorageManager.shared.getDownloadURL(for: metadata.path)
            })
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription
                case .finished:
                    self?.updateUserData()
                }
            } receiveValue: { [weak self] url in
                self?.avatarPath = url.absoluteString
            }
            .store(in: &subscription)
    }
    
    private func updateUserData() {
        guard let avatarPath, let username, let displayName, let bio, let id = Auth.auth().currentUser?.uid else { return }
        let updatedFields: [String: Any] = [
            "displayName": displayName,
            "username": username,
            "bio": bio,
            "avatarPath": avatarPath,
            "isUserOnboard": true
        ]
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: id)
            .sink{ [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] updated in
                self?.isOnboardingFinished = updated
            }.store(in: &subscription)
    }
}

//
//  StorageManager.swift
//  X
//
//  Created by Mabast on 2024-08-26.
//

import Foundation
import Combine
import Firebase
import FirebaseStorage
import FirebaseStorageCombineSwift

enum FirebaseError: Error {
    case imageInvalidID
}

final class StorageManager {
    static let shared = StorageManager()
    
    let storage = Storage.storage()
    
    func getDownloadURL(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id else {
            return Fail(error: FirebaseError.imageInvalidID).eraseToAnyPublisher()
        }
        return storage
            .reference(withPath: id)
            .downloadURL()
            .print()
            .eraseToAnyPublisher()
    }
    
    func uploadProfilePhoto(with randomID: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("images/\(randomID).jpg")
            .putData(image, metadata: metaData)
            .print()
            .eraseToAnyPublisher()
    }
}

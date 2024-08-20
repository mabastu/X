//
//  DatabaseManager.swift
//  X
//
//  Created by Mabast on 2024-08-19.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    
    let database = Firestore.firestore()
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let xUser = XUser(from: user)
        return database.collection("users").document(xUser.id).setData(from: xUser)
            .map { _ in
                return true
            }.eraseToAnyPublisher()
    }
    
    func collectionUsers(retreive id: String) -> AnyPublisher<XUser, Error> {
        database.collection("users").document(id).getDocument()
            .tryMap {
                try $0.data(as: XUser.self)
            }
            .eraseToAnyPublisher()
    }
}

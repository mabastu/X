//
//  AuthenticationViewModel.swift
//  X
//
//  Created by Mabast on 2024-08-18.
//

import Foundation
import Combine
import FirebaseAuth

final class AuthenticationViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    private var subscription: Set<AnyCancellable> = []
    
    func validateAuthentication() {
        guard let email = email, let password = password else {
            isAuthenticationValid = false
            return
        }
        isAuthenticationValid = isValidEmail(email) && password.count >= 8
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func createUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.registerUser(email: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.createRecord(for: user)
            }
            .store(in: &subscription)
    }
    
    func createRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("Adding a user to the database: \(state)")
            }
            .store(in: &subscription)
    }
    
    func loginUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.loginUser(email: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscription)
    }
    
}

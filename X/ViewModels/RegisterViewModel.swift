//
//  RegisterViewModel.swift
//  X
//
//  Created by Mabast on 2024-08-18.
//

import Foundation
import Combine
import FirebaseAuth

final class RegisterViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isRegistrationValid: Bool = false
    @Published var user: User?
    private var subscription: Set<AnyCancellable> = []
    
    func validateRegistration() {
        guard let email = email, let password = password else {
            isRegistrationValid = false
            return
        }
        isRegistrationValid = isValidEmail(email) && password.count >= 8
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func createUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.registerUser(email: email, password: password)
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscription)
    }
    
}

//
//  RegisterVC.swift
//  X
//
//  Created by Mabast on 2024-08-18.
//

import UIKit
import Combine

class RegisterVC: UIViewController {
    
    private var viewModel = AuthenticationViewModel()
    private var subscription: Set<AnyCancellable> = []
    
    private let registerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.gray])
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.gray])
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Acoount", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.isEnabled = false
        button.backgroundColor = .label
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(registerTitle)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        setupConstraints()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismissKeyboard)))
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        bindViews()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            registerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            registerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: registerTitle.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: 180),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        viewModel.$isAuthenticationValid.sink { [weak self] validationState in
            if let self = self {
                self.registerButton.isEnabled = validationState
                self.registerButton.backgroundColor = validationState ? .label : .systemGray5
            }
        }.store(in: &subscription)
        
        viewModel.$user.sink { [weak self] user in
            guard let self = self else { return }
            guard user != nil else { return }
            guard let vc = self.navigationController?.viewControllers.first as? OnboardingVC else { return }
            vc.dismiss(animated: true)
        }.store(in: &subscription)
        
        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(error)
        }.store(in: &subscription)
    }
    
    private func presentAlert(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func emailTextFieldDidChange() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthentication()
    }
    
    @objc private func passwordTextFieldDidChange() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthentication()
    }
    
    @objc private func didTapToDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapRegister() {
        viewModel.createUser()
    }
}

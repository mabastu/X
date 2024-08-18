//
//  LoginVC.swift
//  X
//
//  Created by Mabast on 2024-08-18.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    
    private var viewModel = AuthenticationViewModel()
    private var subscription: Set<AnyCancellable> = []
    
    private let loginTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account"
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
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
        view.addSubview(loginTitle)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        setupConstraints()
        bindViews()
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 180),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        viewModel.$isAuthenticationValid.sink { [weak self] validationState in
            if let self = self {
                self.loginButton.isEnabled = validationState
                self.loginButton.backgroundColor = validationState ? .label : .systemGray5
            }
        }.store(in: &subscription)
        
        viewModel.$user.sink { [weak self] user in
            guard let self = self else { return }
            guard user != nil else { return }
            guard let vc = self.navigationController?.viewControllers.first as? OnboardingVC else { return }
            vc.dismiss(animated: true)
        }.store(in: &subscription)
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
    
    @objc private func didTapLogin() {
        viewModel.loginUser()
    }
}

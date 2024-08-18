//
//  RegisterVC.swift
//  X
//
//  Created by Mabast on 2024-08-18.
//

import UIKit

class RegisterVC: UIViewController {
    
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
        button.setTitleColor(.blackTextOnWhite, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
    
}

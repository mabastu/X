//
//  OnboardingVC.swift
//  X
//
//  Created by Mabast on 2024-08-17.
//

import UIKit

class OnboardingVC: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "See what's happening in the world right now."
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let createAccount: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .label
        button.layer.cornerRadius = 30
        button.tintColor = .systemBackground
        return button
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already have an account?"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let login: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(createAccount)
        view.addSubview(promptLabel)
        view.addSubview(login)
        setupConstraints()
        
        createAccount.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        login.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc private func didTapCreateAccount() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLogin() {
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createAccount.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccount.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
            createAccount.heightAnchor.constraint(equalToConstant: 60),
            
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            login.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 8),
            login.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor),
            
        ])
    }
}

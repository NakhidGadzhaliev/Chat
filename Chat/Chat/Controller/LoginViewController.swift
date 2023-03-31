//
//  LoginViewController.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    lazy var emailTF = EmailTFView(frame: .zero)
    lazy var passwordTF = PasswordTFView(frame: .zero)
    lazy var errorDescription: ErrorDescriptionLabel = {
        let error = ErrorDescriptionLabel(frame: .zero)
        error.textColor = .white
        
        return error
    }()
    lazy var loginButton: LoginButton = {
        let log = LoginButton(frame: .zero)
        log.backgroundColor = .clear
        return log
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        setupConstraints()
        loginSetup()
        
    }
    
}




//MARK: - ADDING ACTIONS
extension LoginViewController {
    
    @objc private func loginTapped() {
        
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let err = error {
                self?.errorDescription.text = err.localizedDescription
                self?.errorDescription.isHidden = false
            } else {
                let vc = ChatViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
}




// MARK: - ADDING METHODS
extension LoginViewController {
    
    private func loginSetup() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func viewSetup() {
        view.backgroundColor = UIColor(named: K.BrandColors.blue)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        view.addSubview(errorDescription)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            emailTF.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            emailTF.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            emailTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailTF.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTF.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            passwordTF.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 15),
            passwordTF.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            errorDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorDescription.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            errorDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            errorDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
    }
    
}


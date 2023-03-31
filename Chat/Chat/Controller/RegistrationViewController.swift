//
//  RegistrationViewController.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    lazy var emailTF = EmailTFView(frame: .zero)
    lazy var passwordTF = PasswordTFView(frame: .zero)
    lazy var registerButton = RegisterButton(frame: .zero)
    lazy var errorDescription = ErrorDescriptionLabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        setupConstraints()
        buttonSetup()
        emailTF.delegate = self
        passwordTF.delegate = self
    }

}




//MARK: - ADDING ACTIONS
extension RegistrationViewController {
    
    @objc private func registerTapped() {
        
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let err = error {
                self?.errorDescription.isHidden = false
                self?.errorDescription.text = err.localizedDescription
            } else {
                let vc = ChatViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
        }

    }
    
}





// MARK: - ADDING METHODS
extension RegistrationViewController {
    
    private func buttonSetup() {
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    private func viewSetup() {
        view.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(registerButton)
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
            
            registerButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 15),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            errorDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorDescription.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            errorDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            errorDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
    }
    
}

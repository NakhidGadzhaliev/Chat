//
//  WelcomeViewController.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    lazy var chatLabel = FlashChatLabel(frame: .zero)
    lazy var registrationButton: RegisterButton = {
        let reg = RegisterButton(frame: .zero)
        reg.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
        
        return reg
    }()
    lazy var loginButton = LoginButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        setupConstraints()
        setupButtons()
        setupLabelText()
    }
    
}




// MARK: - ADDING ACTIONS
extension WelcomeViewController {
    
    @objc private func goToRegisterView() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToLoginView() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}




// MARK: - ADDING METHODS
extension WelcomeViewController {
    
    private func setupLabelText() {
        let titleText = K.appName
        chatLabel.text = ""
        var time = 1.0
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * time, repeats: false) { timer in
                self.chatLabel.text?.append(letter)
            }
            time += 1
        }
    }
    
    private func setupButtons() {
        
        registrationButton.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(goToLoginView), for: .touchUpInside)
        
    }
    
    private func viewSetup() {
        view.backgroundColor = .white
        view.addSubview(chatLabel)
        view.addSubview(registrationButton)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            chatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
}

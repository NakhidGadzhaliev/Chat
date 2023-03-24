//
//  LoginButton.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit

class LoginButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
        setTitle("Log In", for: .normal)
        backgroundColor = .systemTeal
        titleLabel?.font = .systemFont(ofSize: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


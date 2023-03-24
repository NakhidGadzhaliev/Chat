//
//  PasswordTFView.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit

class PasswordTFView: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = "Password"
        backgroundColor = .white
        layer.cornerRadius = 25
        textColor = UIColor(named: K.BrandColors.blue)
        font = .systemFont(ofSize: 25)
        minimumFontSize = 17
        textAlignment = .center
        isSecureTextEntry = true
        layer.shadowColor = CGColor(gray: 0.2, alpha: 0.2)
        layer.shadowOpacity = 0.4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


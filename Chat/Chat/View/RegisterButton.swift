//
//  RegisterButton.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit

class RegisterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(UIColor(named: K.BrandColors.blue), for: .normal)
        setTitle("Register", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  ErrorDescriptionLabel.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 23.03.2023.
//

import UIKit

class ErrorDescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        numberOfLines = 0
        textColor = UIColor(named: K.BrandColors.blue)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

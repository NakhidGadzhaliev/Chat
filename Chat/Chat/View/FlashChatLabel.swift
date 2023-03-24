//
//  FlashChatLabel.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit

class FlashChatLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor(named: K.BrandColors.blue)
        text = ""
        font = .systemFont(ofSize: 50, weight: .black)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

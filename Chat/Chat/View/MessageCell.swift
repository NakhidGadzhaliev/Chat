//
//  MessageCell.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 24.03.2023.
//

import UIKit

class MessageCell: UITableViewCell {
    
    static let identifier = "MessageCell"

    @IBOutlet weak var messageBuble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var youImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 5
        messageLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

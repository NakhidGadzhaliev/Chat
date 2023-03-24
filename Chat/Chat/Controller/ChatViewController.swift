//
//  ChatViewController.swift
//  Chat
//
//  Created by Нахид Гаджалиев on 22.03.2023.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        //        table.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        table.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: MessageCell.identifier)
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = .clear
        
        return table
    }()
    
    lazy var messageTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Write your message..."
        tf.font = .systemFont(ofSize: 14)
        tf.textColor = UIColor(named: K.BrandColors.purple)
        tf.minimumFontSize = 17
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: K.BrandColors.lightPurple)
        
        return button
    }()
    
    lazy var bottomStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [messageTF, sendButton])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.distribution = .fill
        stack.alignment = .center
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUpdate()
        setConstraints()
        setupNavigation()
        tableViewUpdate()
        sendButtonConfigure()
        loadMessages()
    }
    
    
}





// MARK: - ADDING ACTIONS
extension ChatViewController {
    
    @objc private func sendPressed() {
        guard let messageBody = messageTF.text else { return }
        guard let messageSender = Auth.auth().currentUser?.email else { return }
        
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField : messageSender,
            K.FStore.bodyField : messageBody,
            K.FStore.dateField : Date().timeIntervalSince1970
        ]) { error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.messageTF.text = ""
                }
            }
        }
    }
    
    @objc private func logOutTapped() {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out:", signOutError)
        }
        
    }
    
}




// MARK: - ADDING METHODS
extension ChatViewController {
    
    private func sendButtonConfigure() {
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
    }
    
    //Loading messages from cloud
    private func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let err = error {
                print(err.localizedDescription)
            } else {
                if let snapDocs = querySnapshot?.documents {
                    for doc in snapDocs {
                        let data = doc.data()
                        guard let sender = data[K.FStore.senderField] as? String else { return }
                        guard let messageBody = data[K.FStore.bodyField] as? String else { return }
                        
                        let newMessage = Message(sender: sender, body: messageBody)
                        self.messages.append(newMessage)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            // Для скролла вниз при отправке сообщения
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                        
                    }
                }
            }
        }
    }
    
    private func setupNavigation() {
        
        title = K.appName
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logOutTapped))
    }
    
    private func tableViewUpdate() {
        tableView.dataSource = self
        
    }
    
    private func viewUpdate() {
        view.addSubview(tableView)
        view.addSubview(bottomStack)
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            bottomStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStack.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomStack.topAnchor),
            messageTF.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}




// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        cell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youImage.isHidden = true
            cell.avatarImage.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.youImage.isHidden = false
            cell.avatarImage.isHidden = true
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
       
        return cell
    }
    
}

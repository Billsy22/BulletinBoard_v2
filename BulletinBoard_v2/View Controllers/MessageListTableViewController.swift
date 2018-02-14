//
//  MessageListTableViewController.swift
//  BulletinBoard_v2
//
//  Created by Taylor Bills on 2/14/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import UIKit

class MessageListTableViewController: UITableViewController {

    // MARK: -  Properties
    
    @IBOutlet weak var messageTextField: UITextField!
    
    // MARK: -  Actions
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        MessageController.shared.saveMessageWith(text: text)
        DispatchQueue.main.async {
            self.messageTextField.text = ""
            self.tableView.reloadData()
        }
    }
    
    // MARK: -  Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageController.shared.load()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name("MessagesUpdated"), object: nil)
    }
    
    // MARK: -  Table View Data Source Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let message = MessageController.shared.messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = "\(message.date)"
        return cell
    }
    
    @objc func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.messageTextField.text = ""
        }
    }
}

//
//  MessageController.swift
//  BulletinBoard_v2
//
//  Created by Taylor Bills on 2/14/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation

class MessageController {
    
    // MARK: -  Properties
    static let shared = MessageController()
    let cloudKitManager = CloudKitManager()
    var messages: [Message] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("MessagesUpdated"), object: nil)
        }
    }
    
    // MARK: -  CRUD
    
    func saveMessageWith(text: String) {
        let newMessage = Message(text: text)
        cloudKitManager.save(message: newMessage) { (_, error) in
            if let error = error {
                print("Error saving to the cloud: \(error.localizedDescription)")
                return
            } else {
                self.messages.insert(newMessage, at: 0)
            }
        }
    }
    
    func load() {
        cloudKitManager.fetch { (records, error) in
            if let error = error {
                print("Error loading from the cloud \(error.localizedDescription)")
                return
            }
            
            guard let records = records else { return }
            
            var messagesFromTheCloud: [Message] = []
            for record in records {
                guard let newMessage = Message(record: record) else { continue }
                messagesFromTheCloud.append(newMessage)
            }
            self.messages = messagesFromTheCloud
        }
    }
}

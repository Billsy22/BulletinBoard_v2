//
//  CloudKitManager.swift
//  BulletinBoard_v2
//
//  Created by Taylor Bills on 2/14/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    // MARK: -  Properties
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    // MARK: -  CloudKit function
    
    func save(message: Message, completion: @escaping((CKRecord?, Error?) -> Void)) {
        publicDatabase.save(message.asCKRecord, completionHandler: completion)
    }
    
    func fetch(completion: @escaping(([CKRecord]?, Error?) -> Void)) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Message.CloudKitKeys.messageType, predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}

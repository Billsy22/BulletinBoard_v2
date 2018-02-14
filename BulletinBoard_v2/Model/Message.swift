//
//  Message.swift
//  BulletinBoard_v2
//
//  Created by Taylor Bills on 2/14/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
    
    // MARK: -  Properties
    let text: String
    let date: Date
    let cloudKitID: CKRecordID?
    var asCKRecord: CKRecord {
        let record: CKRecord
        if cloudKitID == nil {
            record = CKRecord(recordType: CloudKitKeys.messageType)
        } else {
            record = CKRecord(recordType: CloudKitKeys.messageType, recordID: cloudKitID!)
        }
        record.setObject(text as CKRecordValue, forKey: CloudKitKeys.text)
        record.setObject(date as CKRecordValue, forKey: CloudKitKeys.date)
        return record
    }
    
    // MARK: -  Constants
    enum CloudKitKeys {
        static let messageType = "Message"
        static let text = "text"
        static let date = "date"
        
    }
    
    // MARK: -  Initializers
    
    // Memberwise
    init(text: String) {
        self.text = text
        self.date = Date()
        self.cloudKitID = nil
    }
    
    // Failable
    init?(record: CKRecord) {
        guard let text = record.object(forKey: CloudKitKeys.text) as? String, let date = record.object(forKey: CloudKitKeys.date) as? Date else { return nil }
        self.text = text
        self.date = date
        self.cloudKitID = record.recordID
    }
}

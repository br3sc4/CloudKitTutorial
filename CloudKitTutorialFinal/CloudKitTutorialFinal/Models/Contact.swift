//
//  Contact.swift
//  CloudKitTutorial
//
//  Created by Lorenzo Brescanzin on 06/02/23.
//

import Foundation
import CloudKit

protocol CloudKitUploadable {
    var record: CKRecord { get }
    init?(from record: CKRecord)
}

struct Contact: Identifiable, CloudKitUploadable {
    let name: String
    var record: CKRecord
    
    var id: CKRecord.ID {
        record.recordID
    }
    
    
    init(name: String) {
        let record = CKRecord(
            recordType: "Contact",
            recordID: CKRecord.ID(recordName: UUID().uuidString)
        )
        record["name"] = name
        self.record = record
        self.name = name
    }
    
    init?(from record: CKRecord) {
        guard let name = record["name"] as? String else { return nil }
        self.name = name
        self.record = record
    }
}

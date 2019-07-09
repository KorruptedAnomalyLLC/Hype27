//
//  Hype.swift
//  Hype27
//
//  Created by Austin West on 7/9/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordTypeKey = "Hype"
    fileprivate static let recordTextKey = "Text"
    fileprivate static let recordTimestampKey = "Timestamp"
}

class Hype {
    
    let hypeText: String
    let timestamp: Date
    // Creating a Hype                  Memberwise/Designated initializer
    init(hypeText: String, timestamp: Date = Date()) {
        self.hypeText = hypeText
        self.timestamp = timestamp
    }
}

extension Hype {
    // Creating a Hype from a record                   (failable/convenience initializer should be in a seperate extension)
    convenience init?(ckRecord: CKRecord) {
        guard let hypeText = ckRecord[Constants.recordTextKey] as? String, let hypeTimestamp = ckRecord[Constants.recordTimestampKey] as? Date else { return nil }
        // Creating a Hype from the CKRecord on the cloud and inserting it into the local model Hype
        self.init(hypeText: hypeText, timestamp: hypeTimestamp)
    }
}

// Creating a CKRecord
extension CKRecord {
    convenience init(hype: Hype) {
        self.init(recordType: Constants.recordTypeKey)
        self.setValue(hype.hypeText, forKey: Constants.recordTextKey)
        self.setValue(hype.timestamp, forKey: Constants.recordTimestampKey )
    }
}

//
//  HypeController.swift
//  Hype27
//
//  Created by Austin West on 7/9/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    
    //MARK: - Hype cannot be controlled
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // Singleton
    static let shared = HypeController()
    
    // Source of Truth
    var hypes: [Hype] = []
    
    // CRUD
    
    // Save
    
    func saveHype(with text: String, completion: @escaping (Bool) -> Void) {
        
        let hype = Hype(hypeText: text)
        let hypeRecord = CKRecord(hype: hype)
        publicDB.save(hypeRecord) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription)  /n---n/n \(error)")
                completion(false)
                return
            }
            self.hypes.insert(hype, at: 0)
            completion(true)
        }
    }
    // Fetch
    
    func fetchDemHypes(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.recordTypeKey, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Constants.recordTimestampKey, ascending: false)]
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription)  /n---n/n \(error)")
                completion(false)
                return
            }
            guard let records = records else { completion(false); return }
            let hypes = records.compactMap({Hype(ckRecord: $0)})
            self.hypes = hypes
            completion(true)
        }
    }
    
    // Subscription
    
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
} // end of class

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
            self.hypes.append(hype)
            completion(true)
        }
    }
    // Fetch
    
    func fetchDemHypes(completion: @escaping (Bool) -> Void) {
        
    }
    
    // Subscription
    
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
} // end of class

//
//  Realm.swift
//  TodoApp
//
//  Created by Shin Nguyen on 8/17/19.
//  Copyright © 2019 Shin Nguyen. All rights reserved.
//

public extension Realm {
    static func writeAndLogIfFail(_ realm: Realm, action: @escaping () -> ()) {
        if realm.isInWriteTransaction {
            print("[Realm] Already in write transaction")
            return
        }
        do {
            try realm.write {
                action()
            }
        } catch (let error as NSError) {
            print("[Realm] Error when write to Realm. Error: \(error)")
        }
    }
    
    static func createAndLogIfFail(_ config: Realm.Configuration? = nil) -> Realm? {
        var realm: Realm? = nil
        do {
            if let config = config {
                realm = try Realm(configuration: config)
            } else {
                realm = try Realm()
            }
            
        } catch let error {
            print("[Realm] Error when create Realm object. Error: \(error)")
        }
        
        return realm
    }
}

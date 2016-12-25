//
//  RealmManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation
import RealmSwift

public class DataManager {

    /// Creates and in-memory Realm in case we are running in a unit testing target, otherwise uses a normal on-disk Realm.
    ///
    /// - Returns: An in-memory on an on-disk Realm depending on the environment. 
    public class func realm() -> Realm {
        do {
            if let _ = NSClassFromString("XCTest") {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TimelineParser"
                return try! Realm()
            } else {
                let config = Realm.Configuration(
                    schemaVersion: 1,
                    migrationBlock: { migration, oldSchemaVersion in
                        if oldSchemaVersion < 1 {
                            // Update custom properties here
                        }
                })
                Realm.Configuration.defaultConfiguration = config
                return try Realm()
            }
        } catch {
            fatalError("Could not initialize a Realm instance: \(error)")
        }
    }

    /// Logs out the current user and cleans the Realm database.
    public class func logOut() {
        TwitterSession.shared.logOutUser()
        try! self.realm().write {
            realm().deleteAll()
        }
    }
}

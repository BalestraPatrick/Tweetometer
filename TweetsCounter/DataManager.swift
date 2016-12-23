//
//  RealmManager.swift
//  TweetsCounter
//
//  Created by Patrick Balestra on 12/12/16.
//  Copyright © 2016 Patrick Balestra. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {

    /// Creates and in-memory Realm in case we are running in a unit testing target, otherwise uses a normal on-disk Realm.
    ///
    /// - Returns: An in-memory on an on-disk Realm depending on the environment. 
    class func realm() -> Realm {
        do {
            if let _ = NSClassFromString("XCTest") {
                return try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "TimelineParser", syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, objectTypes: nil))
            } else {
                return try Realm()
            }
        } catch {
            fatalError("Could not initialize a Realm instance: \(error)")
        }
    }
}

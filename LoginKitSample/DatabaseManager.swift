//
//  DatabaseManager.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import FirebaseFirestore

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private var db = Firestore.firestore()
    
    public func addUserInfo(data: [String: String]) {
        db.collection("users").addDocument(data: data)
    }
}

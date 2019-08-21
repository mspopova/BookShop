//
//  StorageManager.swift
//  BookShop
//
//  Created by Марина Попова on 21/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject (_ book: Book) {
        try! realm.write {
            realm.add(book)
        }
    }
    
    static func deleteObject(_ book: Book){
        try! realm.write{
            realm.delete(book)
        }
    }
    
}

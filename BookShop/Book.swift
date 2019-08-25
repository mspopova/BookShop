//
//  Book.swift
//  BookShop
//
//  Created by Марина Попова on 20/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import RealmSwift

class Book: Object, Codable {
    @objc dynamic var name = ""
    @objc dynamic var author = ""
    @objc dynamic var price = 0
    @objc dynamic var imageData: Data?
    
    convenience init(name: String, author: String, price: Int, imageData: Data?){
        self.init()
        self.name = name
        self.author = author
        self.price = price
        self.imageData = imageData
    }
    
    func getBooks(){
        let books = PlistManager.getPlist(withName: "Books")
        
        for book in books{
            StorageManager.saveObject(book)
        }
    }
    
}

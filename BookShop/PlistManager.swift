//
//  PlistManager.swift
//  BookShop
//
//  Created by Марина Попова on 20/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import Foundation

class PlistManager {
    static func getPlist(withName name: String) -> [Book]{
        var books = [Book]()
        //print("Start reading plist file")
        guard let classURL = Bundle.main.url(forResource: name, withExtension:"plist") else {
            print("Error: Unable to form path")
            return books
        }
        
        guard let data = try? Data(contentsOf:classURL)  else {
            print("Error: Invalid Data")
            return books
        }
       
        guard let classData = try? PropertyListDecoder().decode([[String:String]].self, from: data) else {
            print("Error: Bad data format for property list")
            return books
        }
        
        for book in classData {
            if let name = book["name"],
                let author = book["author"],
                let price = book["price"]
            {
                
                let book = Book(name: name, author: author, price: Int(price)!,imageData: nil)
                books.append(book)
                
            }
            
        }
        return books
    }
}


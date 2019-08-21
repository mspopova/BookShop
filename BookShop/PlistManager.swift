//
//  PlistManager.swift
//  BookShop
//
//  Created by Марина Попова on 20/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import Foundation

class PlistManager {
    //TODO: - fix return books
    static func getPlist(withName name: String) -> [Book]{
        var books = [Book]()
        //print("Start reading plist file")
        guard let classURL = Bundle.main.url(forResource: name, withExtension:"plist") else {
            print("Error: Unable to form path")
            return books
        }
        // data in resource file
        // Note: Using try requires catch
        // Note: Using try? converts thrown error to nil
        guard let data = try? Data(contentsOf:classURL)  else {
            print("Error: Invalid Data")
            return books
        }
        // convert the class data plist to a [String:String] dictionary
        guard let classData = try? PropertyListDecoder().decode([[String:String]].self, from: data) else {
            print("Error: Bad data format for property list")
            return books
        }
        // print the name
        // Note: Accessing any part of a Dictionary produces an optional since the key may not exist
        // Note: An if..let or a guard will have to be used for every access to the dictionary
        // Note: Consider the Codable approach into a struct instead
        for book in classData {
            if let name = book["name"],
                let author = book["author"],
                let price = book["price"]
            {
                let book = Book(name: name, author: author, price: Int(price)!)
                books.append(book)
                //print(name, author, price)
                // here create struct and append to array
            }
            
        }
        return books
    }
    
//    static func printBooks(withName books: [Book], state: String){
//        print(state)
//        for book in books{
//            print("\t", book.name, "|", book.author, "|", book.price)
//        }
// }
    
//    static func saveToPlist(withName name: String, object: Book){
//        var books = self.getPlist(withName: "Books")
//        self.printBooks(withName: books, state: "!!!Before!!!")
//        let fileName = "Books.plist" //todo
//        let url = URL(fileURLWithPath: fileName)
//        
//        do {
//            //let data = try Data(contentsOf: url)
//            //var array = try PropertyListSerialization.propertyList(from: data, format: nil) as! [[String:Any]]
//            guard let classURL = Bundle.main.url(forResource: name, withExtension:"plist") else {
//                print("Error: Unable to form path")
//                return
//            }
//            // data in resource file
//            // Note: Using try requires catch
//            // Note: Using try? converts thrown error to nil
//            guard let data = try? Data(contentsOf:classURL)  else {
//                print("Error: Invalid Data")
//                return
//            }
//            // convert the class data plist to a [String:String] dictionary
//            guard var array = try? PropertyListDecoder().decode([[String:String]].self, from: data) else {
//                print("Error: Bad data format for property list")
//                return
//            }
//
//            array.append(["name" : object.name, "author" : object.author, "price": String(object.price)])
//            let writeData = try PropertyListSerialization.data(fromPropertyList: array, format: .xml, options:0)
//            try writeData.write(to: classURL)
//        } catch {
//            print(error)
//        }
//        
//        books = self.getPlist(withName: "Books")
//        self.printBooks(withName: books, state: "After")
//
//    
//    }
    
   
}

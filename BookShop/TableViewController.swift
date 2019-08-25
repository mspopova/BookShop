//
//  TableViewController.swift
//  BookShop
//
//  Created by Марина Попова on 20/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    var books: Results<Book>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = realm.objects(Book.self)
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.isEmpty ? 0: books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let book = books[indexPath.row]
        cell.nameLabel.text = book.name
        cell.authorLabel.text = book.author
        cell.priceLabel.text = "\(book.price)₽"
        
        let image = #imageLiteral(resourceName: "LaunchScreenImg")
        let data = image.pngData()
        cell.imageOfBook.image = UIImage(data: book.imageData ?? data!)
        cell.imageOfBook.layer.cornerRadius = cell.imageOfBook.frame.size.height / 2
        cell.imageOfBook.clipsToBounds = true
        
        return cell
    }
    
    //MARK: - delete action
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let book = books[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_,_) in
            StorageManager.deleteObject(book)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        return [deleteAction ]
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let book = books[indexPath.row]
            let newPlaceVC = segue.destination as! NewBookViewController
            newPlaceVC.currentBook = book
        }
    }

}

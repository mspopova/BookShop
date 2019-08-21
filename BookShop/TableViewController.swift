//
//  TableViewController.swift
//  BookShop
//
//  Created by Марина Попова on 20/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //var books = PlistManager.getPlist(withName: "Books")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return books.count
//    }

    @IBAction func addBook(_ sender: Any) {
        
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//        cell.nameLabel.text = books[indexPath.row].name
//        cell.authorLabel.text = books[indexPath.row].author
//        cell.priceLabel.text = "\(books[indexPath.row].price)₽"
//        return cell
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

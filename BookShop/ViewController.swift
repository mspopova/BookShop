//
//  ViewController.swift
//  BookShop
//
//  Created by Марина Попова on 20/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    var newBook = Book()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sellButton.layer.cornerRadius = 15
        self.buyButton.layer.cornerRadius = 15
        
////////UNCOMMENT TO LOAD DATA FROM PLIST//////////

        DispatchQueue.main.async {
            self.newBook.getBooks()}

///////////////////////////////////////////////////
        
    }
    
    @IBAction func cancelAction (_ segue: UIStoryboardSegue){
    }
    
}


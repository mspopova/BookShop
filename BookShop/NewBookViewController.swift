//
//  NewBookViewController.swift
//  BookShop
//
//  Created by Марина Попова on 21/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit

class NewBookViewController: UITableViewController {
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var bookPrice: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        saveButton.isEnabled = false
        bookName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        bookPrice.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        bookAuthor.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

    }
    
    //TODO: другой способ с обзерверами для скрытия клавиатуры при тапе вне клавиатуры
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    func saveNewBook(){
       // newBook = Book(name: bookName.text, author: bookAuthor.text, price: bookPrice.text)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension NewBookViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //отключить клавиатуру по нажатию Done
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged(){
        if bookName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        if bookAuthor.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        if bookPrice.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
        
    }
    
}

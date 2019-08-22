//
//  NewBookViewController.swift
//  BookShop
//
//  Created by Марина Попова on 21/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit

class NewBookViewController: UITableViewController {
    
    var currentBook: Book?
    
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
        setupEditScreen()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setupEditScreen(){
        if currentBook !== nil {
            
            setupNavigationBar()
        
            bookName.text = currentBook?.name
            bookAuthor.text = currentBook?.author
            bookPrice.text = "\(currentBook?.price ?? 0)₽"
        }
    }
    
    private func setupNavigationBar(){
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(ShareButtonTapped))
        
        title = currentBook?.name
        bookName.isUserInteractionEnabled = false
        bookAuthor.isUserInteractionEnabled = false
        bookPrice.isUserInteractionEnabled = false
        
    }
    func saveBook(){
        let newBook = Book(name: bookName.text!, author: bookAuthor.text!, price: Int(bookPrice.text!) ?? 0)
            StorageManager.saveObject(newBook)
    }
    @objc private func ShareButtonTapped(){
        PdfManager.generatePDF(from: currentBook!)
        performSegue(withIdentifier: "showPDF", sender: nil)
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

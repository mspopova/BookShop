//
//  NewBookViewController.swift
//  BookShop
//
//  Created by Марина Попова on 21/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewBookViewController: UITableViewController, UITextViewDelegate {
    
    var currentBook: Book?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var bookDescription: UITextView!
    @IBOutlet weak var bookPrice: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBAction func saveBook(_ sender: Any) {
        saveBook()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        bookDescription.delegate = self
        bookDescription.text = "Введите описание книги"
        bookDescription.textColor = UIColor.lightGray
        
        saveButton.isEnabled = false
        bookName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        bookPrice.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        bookAuthor.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupPreviewScreen()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите описание книги"
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && currentBook == nil {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera",
                                       style: .default) { _ in
                                        self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setupPreviewScreen(){
        if currentBook !== nil {
            
            setupNavigationBar()
            
            if currentBook?.imageData == nil{
                bookImage.image = #imageLiteral(resourceName: "LaunchScreenImg")
                bookImage.contentMode = .scaleAspectFill
            }
            else{
                guard let data = currentBook?.imageData, let image = UIImage(data: data) else {return}
                bookImage.image = image
                bookImage.contentMode = .scaleAspectFit
                bookImage.backgroundColor = UIColor.white
            }
            
            bookName.text = currentBook?.name
            bookAuthor.text = currentBook?.author
            bookPrice.text = "\(currentBook?.price ?? 0)₽"
            bookDescription.textColor = UIColor.black
            bookDescription.text = currentBook?.bookDescription
        }
    }
    
    private func setupNavigationBar(){
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Купить", style: .plain, target: self, action: #selector(BuyBook))
        
        title = currentBook?.name
        navigationController?.setToolbarHidden(false, animated: true)
        
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(title: "Поделиться по email", style: .plain, target: self, action: #selector(ShareButtonTapped))
        )
        self.toolbarItems = items
        
        bookName.isUserInteractionEnabled = false
        bookAuthor.isUserInteractionEnabled = false
        bookPrice.isUserInteractionEnabled = false
        bookDescription.isEditable = false
        
    }
    func saveBook(){
        MBProgressHUD.showAdded(to: view, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
        var image: UIImage?
            if self.bookImage.image ==  #imageLiteral(resourceName: "Photo") {
            image = #imageLiteral(resourceName: "LaunchScreenImg")
        }else {
                image = self.bookImage.image
        }
        let imageData = image?.pngData()
            let newBook = Book(name: self.bookName.text!,
                               author: self.bookAuthor.text!,
                               price: Int(self.bookPrice.text!) ?? 0,
                               imageData: imageData,
                               bookDescription: self.bookDescription.text
                           )
            StorageManager.saveObject(newBook)
            MBProgressHUD.hide(for: self.view, animated: true)
            self.dismiss(animated: true)
            })
    }
    
    @objc private func BuyBook(){
        MBProgressHUD.showAdded(to: view, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            print("buying book...")
            StorageManager.deleteObject(self.currentBook!)
            MBProgressHUD.hide(for: self.view, animated: true)
            self.dismiss(animated: true)
        })
    }
    
    @objc private func ShareButtonTapped(){
        PdfManager.generatePDF(from: currentBook!)
        performSegue(withIdentifier: "showPDF", sender: nil)
    }
}

extension NewBookViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
extension NewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func chooseImagePicker(source: UIImagePickerController.SourceType){
    
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
            }    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        bookImage.image = info[.editedImage] as? UIImage
        bookImage.contentMode = .scaleAspectFill
        dismiss(animated: true)
        
        }
}


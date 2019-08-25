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
    var imageChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var bookName: UITextField!
    @IBOutlet weak var bookPrice: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookImage: UIImageView!
    
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
        if indexPath.row == 0 {
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
    
    private func setupEditScreen(){
        if currentBook !== nil {
            
            setupNavigationBar()
            imageChanged = true
            
            guard let data = currentBook?.imageData, let image = UIImage(data: data) else {return}
            bookImage.image = image
            bookImage.contentMode = .scaleAspectFill
            
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
        var image: UIImage?
        if imageChanged{
            image = bookImage.image
        }else {
            image = #imageLiteral(resourceName: "LaunchScreenImg")
        }
        let imageData = image?.pngData()
        let newBook = Book(name: bookName.text!, author: bookAuthor.text!, price: Int(bookPrice.text!) ?? 0,imageData: imageData)
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
        bookImage.clipsToBounds = true
        imageChanged = true
        dismiss(animated: true)
        
    }
}


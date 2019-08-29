//
//  PDFViewController.swift
//  BookShop
//
//  Created by Марина Попова on 22/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//

import UIKit
import PDFKit
import MessageUI

class PDFViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        
        guard  MFMailComposeViewController.canSendMail() else {
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([""])
        composer.setSubject("Делюсь книгой из приложения books.ru")
        composer.setMessageBody("Привет, посмотри эту книгу на books.ru:", isHTML: true)
        self.present(composer, animated: true, completion: nil)
        
        if let fileData = NSData(contentsOf: PdfManager.path){
            composer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "file.pdf")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pdfView = PDFView()
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if let document = PDFDocument(url: PdfManager.path) {
            pdfView.document = document
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
        }
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed")
        case .saved:
            print("Saved")
        case .sent:
            print("Sent")
        @unknown default:
            print("unknown error")
        }
        dismiss(animated: true, completion: nil)
    }
    

}

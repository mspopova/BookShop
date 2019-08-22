//
//  PdfManager.swift
//  BookShop
//
//  Created by Марина Попова on 21/08/2019.
//  Copyright © 2019 Марина Попова. All rights reserved.
//
import SimplePDF
import Foundation

class PdfManager{
    
    static var path: URL = Bundle.main.url(forResource: "file", withExtension: "pdf")!
    static func generatePDF(from book: Book){
        let A4paperSize = CGSize(width: 595, height: 842)
        let pdf = SimplePDF(pageSize: A4paperSize, pageMargin: 20.0)
        pdf.addText( "Sharing a book from Books.ru" )
        pdf.addLineSpace(20)
        pdf.addText("Name: \(book.name), \nAuthor: \(book.author), \nPrice: \(book.price)")
        pdf.addLineSpace(20)
        pdf.addText("Download books.ru app to find more books!")
        pdf.addImage(UIImage(named: "LaunchScreenImg")!)
//        pdf.addLineSpace(20)
//        pdf.addLineSeparator()
        
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent("file.pdf")
            self.path = fileURL
            let pdfData = pdf.generatePDFdata()
            try pdfData.write(to: fileURL, options: .atomic)
            print("\nThe generated pdf can be found at:")
            print("\n\t\(fileURL)\n")
        }catch {
            print(error)
        }
        
    }
    
}


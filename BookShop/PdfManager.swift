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
    static func check(){
        print("im here")
    }
    static func generatePDF(from book: Book){
        let A4paperSize = CGSize(width: 595, height: 842)
        let pdf = SimplePDF(pageSize: A4paperSize, pageMargin: 20.0)
        
        pdf.addText( "Sharing book from Books.ru" )
        
        pdf.addImage(UIImage(named: "LaunchScreenImg")!)
      //  pdf.addAttributedText( NSAttributedString )
        pdf.addLineSeparator(height: 30)
        pdf.addText("Название\(book.name)")
        
        // or pdf.addLineSeparator() default height is 1.0
        //pdf.addLineSpace(20)
        
        
        //let pdfData = pdf.generatePDFdata()
       // try? pdfData.write(to: path, options: .atomicWrite)
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            let fileName = "example.pdf"
            let documentsFileName = documentDirectories + "/" + fileName
            guard let path = Bundle.main.url(forResource: "file", withExtension: "pdf")
            else {
                print ("bad path")
                return
            }
            let pdfData = pdf.generatePDFdata()
            do{
                try pdfData.write(to: path, options: .atomic)
                print("\nThe generated pdf can be found at:")
                print("\n\t\(path)\n")
            }catch{
                print(error)
            }
        }
        
    }
    
}


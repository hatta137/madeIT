//
//  AttachmentDetailView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 29.07.24.
//

import SwiftUI
import PDFKit

struct AttachmentDetailView: View {
    var attachment: Attachment
    
    var body: some View {
        VStack(spacing: 20) {
            // Dateivorschau
            AttachmentPreview(fileData: attachment.attachmentData)
                .frame(height: 300)
            
            // Dateiinformationen
            Form {
                Section(header: Text("Dateiinformationen")) {
                    Text("Name: \(attachment.name)")
                    Text("Notiz: \(attachment.notes)")
                }
                
                if let customer = attachment.customer {
                    Section(header: Text("Kundeninformationen")) {
                        Text("Kunde: \(customer.name)")
                    }
                }
            }
        }
        .navigationBarTitle("Dateidetails", displayMode: .inline)
        .padding()
    }
}

struct AttachmentPreview: View {
    var fileData: Data?
    
    var body: some View {
        Group {
            if let data = fileData, let uiImage = UIImage(data: data) {
                // Bildvorschau
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if let data = fileData, let pdfDocument = PDFDocument(data: data) {
                // PDF-Vorschau
                PDFKitView(document: pdfDocument)
                    .frame(height: 300)
            } else {
                // Platzhalter für nicht unterstützte Dateien
                Text("Vorschau nicht verfügbar")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    var document: PDFDocument
    
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}



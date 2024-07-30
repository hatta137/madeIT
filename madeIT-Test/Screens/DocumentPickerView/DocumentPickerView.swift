//
//  DocumentPicker.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 29.07.24.
//

import Foundation
import SwiftUI
import UIKit
import SwiftData

struct DocumentPickerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var fileURL: URL?
    
    @State private var name: String = ""
    @State private var notes: String = ""
    @State private var attachmentData: Data?
    @State private var customer: Customer? = nil
    
    @Query var customers: [Customer]
    
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField {
        case name, notes
    }
    
    var body: some View {
        VStack {
            Form {
                customerInformationSection
                documentInformationSection
                
                filePickerSection
                
                Section {
                    Button("Datei Speichern") {
                        saveAttachment()
                    }
                }
            }
        }
    }
    
    private var customerInformationSection: some View {
        Section("Kundeninformation") {
            Picker("Kunde", selection: $customer) {
                Text("Wähle einen Kunden").tag(Customer?.none)
                ForEach(customers, id: \.self) { customer in
                    Text(customer.name).tag(customer as Customer?)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    private var documentInformationSection: some View {
        Section("Dateiinformationen") {
            TextField("Name", text: $name)
                .focused($focusedTextField, equals: .name)
                .onSubmit { focusedTextField = .notes }
                .submitLabel(.next)
            
            TextField("Notiz", text: $notes)
                .focused($focusedTextField, equals: .notes)
                .onSubmit { focusedTextField = nil }
                .submitLabel(.continue)
        }
    }
    
    private var filePickerSection: some View {
        Section {
            Text(fileURL?.lastPathComponent ?? "Keine Datei ausgewählt")
                .fileImporter(isPresented: .constant(true), allowedContentTypes: [.item], allowsMultipleSelection: false) { result in
                    handleFileSelection(result: result)
                }
        }
    }
    
    private func handleFileSelection(result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else {
                print("Keine Datei ausgewählt")
                return
            }
            print("Datei ausgewählt: \(url)")
            fileURL = url
            loadAttachmentData(from: url)
        case .failure(let error):
            print("Fehler beim Importieren der Datei: \(error.localizedDescription)")
        }
    }
    
    private func loadAttachmentData(from url: URL) {
        do {
            let accessGranted = url.startAccessingSecurityScopedResource()
            defer { url.stopAccessingSecurityScopedResource() }
            
            guard accessGranted else {
                print("Zugriff auf die sicherheitsgeschützte Ressource nicht möglich.")
                return
            }
            
            attachmentData = try Data(contentsOf: url)
            print("Dateidaten erfolgreich geladen: \(attachmentData?.count ?? 0) Bytes")
        } catch {
            print("Fehler beim Laden der Dateidaten: \(error.localizedDescription)")
        }
    }
    
    private func saveAttachment() {
        guard let data = attachmentData else {
            print("Fehler: Keine Datei ausgewählt oder Fehler beim Laden der Datei")
            return
        }
        
        let attachmentToSave = Attachment(name: name, notes: notes, attachmentData: data, customer: customer)
        
        do {
            try modelContext.insert(attachmentToSave)
            try modelContext.save()
            print("Attachment saved successfully")
            resetForm()
            dismiss()
        } catch {
            print("Fehler beim Speichern der Datei: \(error.localizedDescription)")
        }
    }
    
    private func resetForm() {
        name = ""
        notes = ""
        attachmentData = nil
        fileURL = nil
    }
}

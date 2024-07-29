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
                
                Section {
                    Text(fileURL?.lastPathComponent ?? "Keine Datei ausgewählt")
                        .fileImporter(isPresented: .constant(true), allowedContentTypes: [.item], allowsMultipleSelection: false) { result in
                            switch result {
                            case .success(let urls):
                                guard let url = urls.first else {
                                    print("No file selected")
                                    return
                                }
                                print("File selected: \(url)")
                                fileURL = url
                                do {
                                    // Start accessing the security-scoped resource
                                    let accessGranted = fileURL?.startAccessingSecurityScopedResource() ?? false
                                    defer { fileURL?.stopAccessingSecurityScopedResource() }
                                    
                                    guard accessGranted else {
                                        print("Unable to access the security-scoped resource.")
                                        return
                                    }
                                    
                                    attachmentData = try Data(contentsOf: url)
                                    print("File data loaded successfully: \(attachmentData?.count ?? 0) bytes")
                                } catch {
                                    print("Error loading file data: \(error.localizedDescription)")
                                }
                            case .failure(let error):
                                print("Error importing file: \(error.localizedDescription)")
                            }
                        }
                }
                
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

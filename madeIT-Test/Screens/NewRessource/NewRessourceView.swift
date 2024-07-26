//
//  NewRessourceView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 24.07.24.
//

import SwiftUI
import SwiftData

struct NewRessourceView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query var customers: [Customer]
    
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField {
        case name, notes, ip, url, userName, password
    }
    
    @State private var newRessource = Ressource(name: "", 
                                                typeOfRessource: .undefined,
                                                notes: "",
                                                ip: "",
                                                url: "",
                                                customer: nil,
                                                userName: "",
                                                password: "")
    
    @State private var clearPassword: String = ""
    @State private var isSaved = false
    
    var body: some View {
        NavigationStack {
            Form {
                customerInformationSection
                deviceInformationSection
                networkInformationSection
                accessInformationSection
                saveButton
            }
        }
        .onAppear {
            // Load the password from the ressource
            clearPassword = newRessource.getPassword() ?? ""
        }
        .onChange(of: clearPassword) { clearPassword, newPassword in
            // Save the encrypted password to the ressource
            newRessource.setPassword(newPassword)
        }
    }
    
    private var customerInformationSection: some View {
        Section("Kundeninformation") {
            List {
                Picker("Kunde", selection: $newRessource.customer) {
                    Text("Wähle einen Kunden").tag(Customer?.none) // Standardtext für den Fall, dass kein Kunde ausgewählt ist
                    ForEach(customers, id: \.self) { customer in
                        Text(customer.name).tag(customer as Customer?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
    }
    
    private var deviceInformationSection: some View {
        Section("Geräteinformationen") {
            TextField("Name", text: $newRessource.name)
                .focused($focusedTextField, equals: .name)
                .onSubmit { focusedTextField = .notes }
                .submitLabel(.next)
            
            TextField("Notiz", text: $newRessource.notes)
                .focused($focusedTextField, equals: .notes)
                .onSubmit { focusedTextField = .ip }
                .submitLabel(.next)
            
            List {
                Picker("Typ", selection: $newRessource.typeOfRessource) {
                    ForEach(TypeOfRessource.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Stil des Pickers
            }
        }
    }
    
    private var networkInformationSection: some View {
        Section("Netzwekinformationen") {
            TextField("IP-Adresse", text: $newRessource.ip)
                .focused($focusedTextField, equals: .ip)
                .onSubmit { focusedTextField = .url }
                .submitLabel(.next)
            
            TextField("URL", text: $newRessource.url)
                .focused($focusedTextField, equals: .url)
                .onSubmit { focusedTextField = .userName }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .submitLabel(.next)
            
        }
    }
    
    private var accessInformationSection: some View {
        Section("Zugangsinformationen") {
            TextField("Username", text: $newRessource.userName)
                .focused($focusedTextField, equals: .userName)
                .onSubmit { focusedTextField = .password }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .submitLabel(.next)
            
            TextField("Password", text: $clearPassword)
                .focused($focusedTextField, equals: .password)
                .onSubmit { focusedTextField = nil }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .submitLabel(.continue)
        }
    }
    
    private var saveButton: some View {
        Button("Save Changes") {
            modelContext.insert(newRessource)
            resetForm()
            isSaved = true
            dismiss()
        }
    }
    
    private func resetForm() {
        newRessource.name = ""
        newRessource.typeOfRessource = .undefined
        newRessource.notes = ""
        newRessource.ip = ""
        newRessource.url = ""
        newRessource.userName = ""
        newRessource.setPassword("")
        newRessource.customer = nil
    }
}
//
//#Preview {
//    NewRessourceView()
//}

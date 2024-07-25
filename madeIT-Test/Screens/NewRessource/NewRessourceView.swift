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
    
    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case name, notes, ip, url, userName, password
    }
    
    @State private var name = ""
    @State private var typeOfRessource: TypeOfRessource = .undefined
    @State private var notes = ""
    @State private var ip = ""
    @State private var url = ""
    @State private var userName = ""
    @State private var password = ""
    @State private var customer: Customer? = nil
    
    @State private var isSaved = false
    
    @Query var customers: [Customer] // Abfrage für alle Kunden
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Kundeninformation") {
                    List {
                        Picker("Kunde", selection: $customer) {
                            Text("Wähle einen Kunden").tag(Customer?.none) // Standardtext für den Fall, dass kein Kunde ausgewählt ist
                            ForEach(customers, id: \.self) { customer in
                                Text(customer.name).tag(customer as Customer?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                
                Section("Geräteinformationen") {
                    TextField("Name", text: $name)
                        .focused($focusedTextField, equals: .name)
                        .onSubmit { focusedTextField = .notes }
                        .submitLabel(.next)
                    
                    TextField("Notiz", text: $notes)
                        .focused($focusedTextField, equals: .notes)
                        .onSubmit { focusedTextField = .ip }
                        .submitLabel(.next)
                    
                    List {
                        Picker("Typ", selection: $typeOfRessource) {
                            ForEach(TypeOfRessource.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Stil des Pickers
                    }
                    
                    
                }
                
                
                
                Section("Netzwekinformationen") {
                    TextField("IP-Adresse", text: $ip)
                        .focused($focusedTextField, equals: .ip)
                        .onSubmit { focusedTextField = .url }
                        .submitLabel(.next)
                    
                    TextField("URL", text: $url)
                        .focused($focusedTextField, equals: .url)
                        .onSubmit { focusedTextField = .userName }
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                    
                }
                Section("Zugangsinformationen") {
                    TextField("Username", text: $userName)
                        .focused($focusedTextField, equals: .userName)
                        .onSubmit { focusedTextField = .password }
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                    
                    TextField("Password", text: $password)
                        .focused($focusedTextField, equals: .password)
                        .onSubmit { focusedTextField = nil }
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.continue)
                    
                }
                Button {
                    let newRessource = Ressource(
                        name: name,
                        typeOfRessource: typeOfRessource,
                        notes: notes,
                        ip: ip,
                        url: url,
                        userName: userName,
                        password: password,
                        customer: customer)
                    
                    modelContext.insert(newRessource)
                    
                    // reset values
                    
                    name = ""
                    typeOfRessource = .undefined
                    notes = ""
                    ip = ""
                    url = ""
                    userName = ""
                    password = ""
                    customer = nil
                    
                    // Mark as saved and trigger navigation
                    isSaved = true
                    dismiss()
                    
                } label: {
                    Text("Save Changes")
                }
            }
        }
    }
}
//
//#Preview {
//    NewRessourceView()
//}

//
//  EditRessourceView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 25.07.24.
//

import SwiftUI
import SwiftData

// TODO Refactoring
struct EditRessourceView: View {
    
    @Binding var ressource: Ressource
    @Binding var isShowingEditView: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query var customers: [Customer] // Abfrage für alle Kunden
    
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField {
        case name, notes, ip, url, userName, password
    }
    
    @State private var clearPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Kundeninformation") {
                    List {
                        Picker("Kunde", selection: $ressource.customer) {
                            Text("Wähle einen Kunden").tag(Customer?.none)
                            ForEach(customers, id: \.self) { customer in
                                Text(customer.name).tag(customer as Customer?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Section("Geräteinformationen") {
                    TextField("Name", text: $ressource.name)
                        .focused($focusedTextField, equals: .name)
                        .onSubmit { focusedTextField = .notes }
                        .submitLabel(.next)
                    
                    TextField("Notiz", text: $ressource.notes)
                        .focused($focusedTextField, equals: .notes)
                        .onSubmit { focusedTextField = .ip }
                        .submitLabel(.next)
                    
                    List {
                        Picker("Typ", selection: $ressource.typeOfRessource) {
                            ForEach(TypeOfRessource.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Stil des Pickers
                    }
                }
                Section("Netzwekinformationen") {
                    TextField("IP-Adresse", text: $ressource.ip)
                        .focused($focusedTextField, equals: .ip)
                        .onSubmit { focusedTextField = .url }
                        .submitLabel(.next)
                    
                    TextField("URL", text: $ressource.url)
                        .focused($focusedTextField, equals: .url)
                        .onSubmit { focusedTextField = .userName }
                        .submitLabel(.next)
                    
                }
                
                Section("Zugangsinformationen") {
                    TextField("Username", text: $ressource.userName)
                        .focused($focusedTextField, equals: .userName)
                        .onSubmit { focusedTextField = .password }
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                    
                    ZStack(alignment: .trailing) {
                        if isPasswordVisible {
                            TextField("Password", text: $clearPassword)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        } else {
                            SecureField("Password", text: $clearPassword)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                        .padding(.trailing, 10)
                    }
                    
                }
                Button {
                    do {
                        try modelContext.save()
                        isShowingEditView = false
                    } catch {
                        print("Failed to save changes: \(error.localizedDescription)")
                    }
                } label: {
                    Text("Änderungen speichern")
                }
            }
            .navigationTitle("Bearbeite Gerät")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            // Load the password from the ressource
            clearPassword = ressource.getPassword() ?? ""
        }
        .onChange(of: clearPassword) { clearPassword, newPassword in
            // Save the encrypted password to the ressource
            ressource.setPassword(newPassword)
        }
    }
}

//#Preview {
//    EditRessourceView()
//}

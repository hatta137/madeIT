//
//  EditRessourceView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 25.07.24.
//

import SwiftUI
import SwiftData

struct EditRessourceView: View {
    
    @Binding var ressource: Ressource
    @Binding var isShowingEditView: Bool
    @Environment(\.modelContext) private var modelContext
    @FocusState private var focusedTextField: FormTextField?
    enum FormTextField {
        case name, notes, ip, url, userName, password
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Geräteinformationen") {
                    TextField("Name", text: $ressource.name)
                        .focused($focusedTextField, equals: .name)
                        .onSubmit { focusedTextField = .notes }
                        .submitLabel(.next)
                    
                    TextField("Notiz", text: $ressource.notes)
                        .focused($focusedTextField, equals: .notes)
                        .onSubmit { focusedTextField = .ip }
                        .submitLabel(.next)
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
                    
                    TextField("Password", text: $ressource.password)
                        .focused($focusedTextField, equals: .password)
                        .onSubmit { focusedTextField = nil }
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.continue)
                    
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
    }
}

//#Preview {
//    EditRessourceView()
//}

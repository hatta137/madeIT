//
//  EditCustomerView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 24.07.24.
//

import SwiftUI
import SwiftData

struct EditCustomerView: View {
    
    @Binding var customer: Customer
    @Binding var isShowingEditView: Bool
    @Environment(\.modelContext) private var modelContext
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField {
        case name, industry, address, contactName, tel, email
    }
    
    var body: some View {
        Form {
            Section("Kundeninformationen") {
                TextField("Firmennamen", text: $customer.name)
                    .focused($focusedTextField, equals: .name)
                    .onSubmit { focusedTextField = .industry }
                    .submitLabel(.next)
                
                TextField("Branche", text: $customer.industry)
                    .focused($focusedTextField, equals: .industry)
                    .onSubmit { focusedTextField = .address }
                    .submitLabel(.next)
                
                TextField("Addresse", text: $customer.address)
                    .focused($focusedTextField, equals: .address)
                    .onSubmit { focusedTextField = .contactName }
                    .submitLabel(.next)
                
            }
            Section("Kontaktperson") {
                TextField("Name", text: $customer.contactName)
                    .focused($focusedTextField, equals: .contactName)
                    .onSubmit { focusedTextField = .tel }
                    .submitLabel(.next)
                
                TextField("Telefonnummer", text: $customer.tel)
                    .focused($focusedTextField, equals: .tel)
                    .onSubmit { focusedTextField = .email }
                    .submitLabel(.next)
                
                TextField("Email", text: $customer.email)
                    .focused($focusedTextField, equals: .email)
                    .onSubmit { focusedTextField = nil }
                    .submitLabel(.continue)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
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
        .navigationTitle("Bearbeite Kunde")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Customer.self, configurations: config)
//        let example = Customer(name: "HL Web Dev", contactName: "Hendrik Lendeckel", tel: "015140244595", email: "hendrik@lendeckel.de", industry: "Webdevelopment", address: "Kurt-Beate-Straße 9, 99086 Erfurt")
//        
//        return EditCustomerView(customer: example, isShowingEditView: .constant(true))
//            .modelContainer(container)
//        
//    } catch {
//        fatalError("failed to create model container")
//    }
//    
//}

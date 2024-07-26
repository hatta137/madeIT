//
//  NewCustomerView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 24.07.24.
//

import SwiftUI
import SwiftData

struct NewCustomerView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedTextField: FormTextField?
    
    @State private var customer = Customer(name: "", contactName: "", tel: "", email: "", industry: .undefined, address: "")
    @State private var isSaved = false
    
    enum FormTextField {
        case name, industry, address, contactname, tel, email
    }
    
    var body: some View {
        NavigationStack {
            Form {
                customerInfoSection
                contactPersonSection
                saveButton
            }
        }
    }
    
    private var customerInfoSection: some View {
        Section("Kundeninformationen") {
            TextField("Firmennamen", text: $customer.name)
                .focused($focusedTextField, equals: .name)
                .onSubmit { focusedTextField = .address }
                .submitLabel(.next)
            
            Picker("Branche", selection: $customer.industry) {
                ForEach(Industry.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            TextField("Addresse", text: $customer.address)
                .focused($focusedTextField, equals: .address)
                .onSubmit { focusedTextField = .contactname }
                .submitLabel(.next)
        }
    }
    
    private var contactPersonSection: some View {
        Section("Kontaktperson") {
            TextField("Name", text: $customer.contactName)
                .focused($focusedTextField, equals: .contactname)
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
    }
    
    private var saveButton: some View {
        Button("Save Changes") {
            modelContext.insert(customer)
            customer = Customer(name: "", contactName: "", tel: "", email: "", industry: .undefined, address: "")
            isSaved = true
            dismiss()
        }
    }
}

//#Preview {
//    NewCustomerView()
//}


//#Preview {
//    NewCustomerView()
//}

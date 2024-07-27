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
    
    @State private var name: String = ""
    @State private var contactName: String = ""
    @State private var tel: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    @State private var industry: Industry = .undefined
    
    
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
            TextField("Firmennamen", text: $name)
                .focused($focusedTextField, equals: .name)
                .onSubmit { focusedTextField = .address }
                .submitLabel(.next)
            
            Picker("Branche", selection: $industry) {
                ForEach(Industry.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            TextField("Addresse", text: $address)
                .focused($focusedTextField, equals: .address)
                .onSubmit { focusedTextField = .contactname }
                .submitLabel(.next)
        }
    }
    
    private var contactPersonSection: some View {
        Section("Kontaktperson") {
            TextField("Name", text: $contactName)
                .focused($focusedTextField, equals: .contactname)
                .onSubmit { focusedTextField = .tel }
                .submitLabel(.next)
            
            TextField("Telefonnummer", text: $tel)
                .focused($focusedTextField, equals: .tel)
                .onSubmit { focusedTextField = .email }
                .keyboardType(.numberPad)
                .submitLabel(.next)
            
            TextField("Email", text: $email)
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
            
            let customer = Customer(name: name, contactName: contactName, tel: tel, email: email, industry: industry, address: address)
            
            modelContext.insert(customer)
            
            name = ""
            contactName = ""
            email = ""
            industry = .undefined
            address = ""
            tel = ""
            isSaved = true
            dismiss()
        }
    }
}



//#Preview {
//    NewCustomerView()
//}

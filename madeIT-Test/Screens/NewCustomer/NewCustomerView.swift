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
    
    @State private var name = ""
    @State private var industry: Industry = .undefined
    @State private var address = ""
    @State private var contactname = ""
    @State private var tel = ""
    @State private var email = ""
    
    @State private var isSaved = false

    
    enum FormTextField {
        case name, industry, address, contactname, tel, email
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Kundeninformationen") {
                    TextField("Firmennamen", text: $name)
                        .focused($focusedTextField, equals: .name)
                        .onSubmit { focusedTextField = .address }
                        .submitLabel(.next)
                    
                    
                    List {
                        Picker("Branche", selection: $industry) {
                            ForEach(Industry.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Stil des Pickers
                    }
                    
                    TextField("Addresse", text: $address)
                        .focused($focusedTextField, equals: .address)
                        .onSubmit { focusedTextField = .contactname }
                        .submitLabel(.next)
                    
                }
                Section("Kontaktperson") {
                    TextField("Name", text: $contactname)
                        .focused($focusedTextField, equals: .contactname)
                        .onSubmit { focusedTextField = .tel }
                        .submitLabel(.next)
                    
                    TextField("Telefonnummer", text: $tel)
                        .focused($focusedTextField, equals: .tel)
                        .onSubmit { focusedTextField = .email }
                        .submitLabel(.next)
                    
                    TextField("Email", text: $email)
                        .focused($focusedTextField, equals: .email)
                        .onSubmit { focusedTextField = nil }
                        .submitLabel(.continue)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                }
                Button {
                    let newCustomer = Customer(name: name, contactName: contactname, tel: tel, email: email, industry: industry, address: address)
                    
                    modelContext.insert(newCustomer)
                    
                    // reset values
                    
                    name = ""
                    industry = .undefined
                    address = ""
                    contactname = ""
                    tel = ""
                    email = ""

                    
                    
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

//#Preview {
//    NewCustomerView()
//}

//
//  NewModal.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct NewModal: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: NewCustomerView()) {
                    Text("Kunde anlegen")
                }
                NavigationLink(destination: NewRessourceView()) {
                    Text("Ressource anlegen")
                }
            }
            .navigationTitle("🆕 Neu anlegen")
        }
    }
    
}

#Preview {
    NewModal()
}

//
//  NewModal.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct NewModalView: View {
    
    
    
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
//
//#Preview {
//    NewModalView()
//}

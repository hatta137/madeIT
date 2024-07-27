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
                NavigationLink(destination: NewResourceView()) {
                    Text("Ressource anlegen")
                }
                NavigationLink(destination: PhotoPickerView()) {
                    Text("Grafik anlegen")
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

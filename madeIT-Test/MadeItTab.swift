//
//  ContentView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct MadeItTab: View {

    
    var body: some View {
        TabView {
            
            CustomerListView()
                .tabItem { Label("Kunden", systemImage: "folder.badge.person.crop") }
  
            ResourceListView()
                .tabItem { Label("Geräte", systemImage: "server.rack") }
            
            AttachmentListView()
                .tabItem { Label("Anhänge", systemImage: "photo.on.rectangle") }
            
            NewModalView()
                .tabItem { Label("Neu", systemImage: "plus") }
               
        }
    }
}

//#Preview {
//    MadeItTab()
//}

//
//  RessourceDetailView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.


import SwiftUI

struct RessourceDetailView: View {
    
    @State var ressource: Ressource
    @State private var isShowingEditView = false
    
    var body: some View {
        VStack {
                       
            
            VStack(alignment: .leading, spacing: 5) {
                
                ContactInfo(image: "server.rack",           info: ressource.name)
                ContactInfo(image: "list.bullet.clipboard", info: ressource.notes)
                ContactInfo(image: "network",               info: ressource.ip)
                ContactInfo(image: "network",               info: ressource.url)
                ContactInfo(image: "person",                info: ressource.userName)
                ContactInfo(image: "key",                   info: ressource.password)
                
            }
            .padding(.bottom, 40)
            
            Button("Bearbeiten") {
                isShowingEditView = true
            }
            .padding(.bottom, 40)
            .sheet(isPresented: $isShowingEditView) {
                EditRessourceView(ressource: $ressource, isShowingEditView: $isShowingEditView)
            }
        }
        .navigationTitle(ressource.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReesourceInfo: View {
    
    let image: String
    let info: String
    
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .padding(.horizontal, 10)
            Text(info)
        }
        .padding(.bottom, 20)
        
    }
}

//
//#Preview {
//    let ressource = Ressource(
//        name: "HyperV",
//        notes: "Ich stehe im Keller",
//        ip: "10.10.10.1",
//        url: "hyperv.local",
//        userName: "admin",
//        password: "admin1234"
//    )
//    return RessourceDetailView(ressource: ressource)
//        .modelContainer(for: [Ressource.self])
//}

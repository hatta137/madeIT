//
//  RessourceDetailView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.


import SwiftUI

struct RessourceDetailView: View {
    
    @State var ressource: Ressource
    @State private var isShowingEditView = false
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                ContactInfo(image: "server.rack",           info: ressource.name)
                ContactInfo(image: "person.crop.circle",    info: ressource.customer?.name ?? "no")
                ContactInfo(image: "xserve",                info: ressource.typeOfRessource.rawValue)
                ContactInfo(image: "list.bullet.clipboard", info: ressource.notes)
                ContactInfo(image: "network",               info: ressource.ip)
                ContactInfo(image: "network",               info: ressource.url)
                ContactInfo(image: "person",                info: ressource.userName)
                
                ZStack(alignment: .trailing) {
                    
                    HStack {
                        
                        Image(systemName: "lock.circle")
                            .padding(.horizontal, 10)
                        
                        if isPasswordVisible {
                            Text(ressource.getPassword() ?? "Kein Passwort")
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        } else {
                            Text(String(repeating: "*", count: (ressource.getPassword() ?? "").count))
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        }
                        
                        
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                        .padding(.horizontal, 40)
                    
                    }
                    
                }
                
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

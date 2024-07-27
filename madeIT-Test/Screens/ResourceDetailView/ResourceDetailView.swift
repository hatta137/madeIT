//
//  RessourceDetailView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.


import SwiftUI

struct ResourceDetailView: View {
    
    @State var resource: Resource
    @State private var isShowingEditView = false
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            
            
            VStack(alignment: .leading, spacing: 5) {
                
                ContactInfo(image: "server.rack",           info: resource.name)
                ContactInfo(image: "person.crop.circle",    info: resource.customer?.name ?? "no")
                ContactInfo(image: "xserve",                info: resource.typeOfRessource.rawValue)
                ContactInfo(image: "list.bullet.clipboard", info: resource.notes)
                ContactInfo(image: "network",               info: resource.ip)
                ContactInfo(image: "network",               info: resource.url)
                ContactInfo(image: "person",                info: resource.userName)
                
                ZStack(alignment: .trailing) {
                    
                    HStack {
                        
                        Image(systemName: "lock.circle")
                            .padding(.horizontal, 10)
                        
                        if isPasswordVisible {
                            Text(resource.getPassword() ?? "Kein Passwort")
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        } else {
                            Text(String(repeating: "*", count: (resource.getPassword() ?? "").count))
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
                EditResourceView(ressource: $resource, isShowingEditView: $isShowingEditView)
            }
        }
        .navigationTitle(resource.name)
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

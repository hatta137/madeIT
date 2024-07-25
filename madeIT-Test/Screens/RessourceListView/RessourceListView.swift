//
//  RessourceListView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI
import SwiftData

struct RessourceListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var ressources: [Ressource]
    
    var body: some View {
        NavigationStack {
            List(ressources) { ressource in
                
                NavigationLink(destination: RessourceDetailView(ressource: ressource)) {
                    VStack(alignment: .leading) {
                        Text(ressource.name)
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        HStack {
                            Text(ressource.ip)
                                .font(.footnote)
                                .fontWeight(.regular)
                            Text(ressource.url)
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                        
                    }
                }
            }
            .navigationTitle("💻 Geräte")
        }
    }
}

#Preview {
    RessourceListView()
}

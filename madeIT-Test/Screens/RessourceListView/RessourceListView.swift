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
            List {
                ForEach(ressources) { ressource in
                    NavigationLink(destination: RessourceDetailView(ressource: ressource)) {
                        VStack(alignment: .leading) {
                            Text(ressource.name)
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            HStack(alignment: .center) {
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
                .onDelete(perform: deleteResource)
            }
            .navigationTitle("💻 Geräte")
        }
    }
    
    func deleteResource(at offsets: IndexSet) {
        for index in offsets {
            let ressource = ressources[index]
            modelContext.delete(ressource)
        }
    }
}

#Preview {
    RessourceListView()
}


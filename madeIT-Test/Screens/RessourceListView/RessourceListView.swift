//
//  RessourceListView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct RessourceListView: View {
    var body: some View {
        NavigationStack {
            List(MockDataResssource.sampleRessources) { ressource in
                
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

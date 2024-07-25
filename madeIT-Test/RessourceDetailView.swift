//
//  RessourceDetailView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct RessourceDetailView: View {
    
    let ressource: Ressource
    
    var body: some View {
        VStack {
            Text("Test")
        }
        .navigationTitle(ressource.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    RessourceDetailView(ressource: MockDataResssource.sampleRessource)
//}

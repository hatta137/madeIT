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
    @Query var customers: [Customer] // Abfrage für alle Kunden
    
    @State private var selectedCustomer: Customer? = nil
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    Picker("Kunde", selection: $selectedCustomer) {
                        Text("Alle Geräte anzeigen").tag(Customer?.none) // Standardtext für den Fall, dass kein Kunde ausgewählt ist
                        ForEach(customers, id: \.self) { customer in
                            Text(customer.name).tag(customer as Customer?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                List {
                    ForEach(filteredRessources) { ressource in
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
            }
            .navigationTitle("💻 Geräte")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var filteredRessources: [Ressource] {
        if let customer = selectedCustomer {
            return ressources.filter { $0.customer?.id == customer.id }
        } else {
            return ressources
        }
    }
    
    func deleteResource(at offsets: IndexSet) {
        for index in offsets {
            let ressource = ressources[index]
            modelContext.delete(ressource)
        }
    }
}
//
//#Preview {
//    RessourceListView()
//}


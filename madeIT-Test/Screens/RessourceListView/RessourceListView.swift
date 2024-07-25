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
    @State private var selectedFilter: FilterType = .alphabetical
    
    enum FilterType {
        case alphabetical
        case typeOfRessource
    }
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    Picker("Kunde", selection: $selectedCustomer) {
                        Text("Alle Ressourcen anzeigen").tag(Customer?.none) // Standardtext für den Fall, dass kein Kunde ausgewählt ist
                        ForEach(customers, id: \.self) { customer in
                            Text(customer.name).tag(customer as Customer?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Filter", selection: $selectedFilter) {
                        Text("Alphabetisch").tag(FilterType.alphabetical)
                        Text("Typ").tag(FilterType.typeOfRessource)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                if filteredAndSortedRessources.isEmpty {
                    Text("Keine Ressourcen angelegt")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(filteredAndSortedRessources) { ressource in
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
            }
            .navigationTitle("💻 Ressourcen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var filteredAndSortedRessources: [Ressource] {
        var filtered = ressources
        
        // Filter nach Kunden
        if let customer = selectedCustomer {
            filtered = filtered.filter { $0.customer?.id == customer.id }
        }
        
        // Sortieren nach ausgewähltem Filter
        switch selectedFilter {
        case .alphabetical:
            return filtered.sorted { $0.name < $1.name }
        case .typeOfRessource:
            return filtered.sorted { $0.typeOfRessource.rawValue < $1.typeOfRessource.rawValue }
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


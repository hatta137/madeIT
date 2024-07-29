//
//  ResourceListView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI
import SwiftData

struct ResourceListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var resources: [Resource]
    @Query var customers: [Customer] // Abfrage für alle Kunden
    
    @State private var selectedCustomer: Customer? = nil
    @State private var selectedFilter: FilterType = .alphabetical
    
    enum FilterType {
        case alphabetical
        case typeOfResource
    }
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    Picker("Kunde", selection: $selectedCustomer) {
                        Text("Alle Resourcen anzeigen").tag(Customer?.none) // Standardtext für den Fall, dass kein Kunde ausgewählt ist
                        ForEach(customers, id: \.self) { customer in
                            Text(customer.name).tag(customer as Customer?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Filter", selection: $selectedFilter) {
                        Text("Alphabetisch").tag(FilterType.alphabetical)
                        Text("Typ").tag(FilterType.typeOfResource)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                if filteredAndSortedResources.isEmpty {
                    Text("Keine Resourcen angelegt")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(filteredAndSortedResources) { resource in
                            NavigationLink(destination: ResourceDetailView(resource: resource)) {
                                VStack(alignment: .leading) {
                                    Text(resource.name)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    HStack(alignment: .center) {
                                        Text(resource.ip)
                                            .font(.footnote)
                                            .fontWeight(.regular)
                                        Text(resource.url)
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
    
    var filteredAndSortedResources: [Resource] {
        var filtered = resources
        
        // Filter nach Kunden
        if let customer = selectedCustomer {
            filtered = filtered.filter { $0.customer?.id == customer.id }
        }
        
        // Sortieren nach ausgewähltem Filter
        switch selectedFilter {
        case .alphabetical:
            return filtered.sorted { $0.name < $1.name }
        case .typeOfResource:
            return filtered.sorted { $0.typeOfResource.rawValue < $1.typeOfResource.rawValue }
        }
    }
    
    func deleteResource(at offsets: IndexSet) {
        for index in offsets {
            let resource = resources[index]
            modelContext.delete(resource)
        }
    }
}
//
//#Preview {
//    ResourceListView()
//}


//
//  CustomerListView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI
import SwiftData

struct CustomerListView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var customers: [Customer]
    
    @StateObject var viewModel = CustomerListViewModel()
    
    @State private var selectedFilter: FilterType = .alphabetical
    
    enum FilterType {
        case alphabetical
        case industry
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                
                Form {
                    Section{
                        Picker("Filter", selection: $selectedFilter) {
                            Text("Alphabetisch").tag(FilterType.alphabetical)
                            Text("Branche").tag(FilterType.industry)
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    if filteredCustomers.isEmpty {
                        Text("Keine Kunden angelegt")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List{
                            ForEach(filteredCustomers) { customer in
                                CustomerListCell(customer: customer)
                                    .onTapGesture {
                                        viewModel.isShowingDetail = true
                                        viewModel.selectedCustomer = customer
                                    }
                            }
                            .onDelete(perform: deleteCustomer(_:))
                            
                        }
                        
                    }
                }
                .navigationTitle("🗃️ Kunden")
                .navigationBarTitleDisplayMode(.inline)
                .disabled(viewModel.isShowingDetail)
                
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                CustomerDetailView(customer: viewModel.selectedCustomer!, isShowingDetail: $viewModel.isShowingDetail)
            }
        }
        
        
    }
    
    var filteredCustomers: [Customer] {
        switch selectedFilter {
        case .alphabetical:
            return customers.sorted { $0.name < $1.name }
        case .industry:
            return customers.sorted { $0.industry.rawValue < $1.industry.rawValue }
        }
    }
    
    func deleteCustomer(_ indexSet: IndexSet) {
        for index in indexSet {
            let customer = customers[index]
            
            for ressource in customer.ressources {
                modelContext.delete(ressource)
            }
            
            modelContext.delete(customer)
        }
    }
}
//
//#Preview {
//    CustomerListView()
//}

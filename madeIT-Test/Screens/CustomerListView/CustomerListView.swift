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

    
    var body: some View {
        ZStack {
            NavigationStack {
                List{
                    ForEach(customers) { customer in
                        CustomerListCell(customer: customer)
                            .onTapGesture {
                                viewModel.isShowingDetail = true
                                viewModel.selectedCustomer = customer
                            }
                    }
                    .onDelete(perform: deleteCustomer(_:))
                    
                }
                .navigationTitle("🗃️ Kunden")
                .disabled(viewModel.isShowingDetail)
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                CustomerDetailView(customer: viewModel.selectedCustomer!, isShowingDetail: $viewModel.isShowingDetail)
            }
        }
        
        
    }
    
    
    func deleteCustomer(_ indexSet: IndexSet) {
        for index in indexSet {
            let customer = customers[index]
            modelContext.delete(customer)
        }
    }
}

#Preview {
    CustomerListView()
}

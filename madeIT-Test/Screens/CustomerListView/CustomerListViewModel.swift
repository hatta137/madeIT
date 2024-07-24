//
//  CustomerListViewModel.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 24.07.24.
//

import SwiftUI

@MainActor final class CustomerListViewModel: ObservableObject {
    
    
    
    @Published var customers: [Customer] = []
    @Published var isShowingDetail = false
    @Published var selectedCustomer: Customer?
    
    

    
}

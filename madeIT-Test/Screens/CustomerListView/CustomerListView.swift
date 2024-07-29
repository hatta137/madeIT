import SwiftUI
import SwiftData

struct CustomerListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var customers: [Customer]
    
    @State private var isShowingDetail = false
    @State private var selectedCustomer: Customer?
    @State private var selectedFilter: FilterType = .alphabetical
    
    enum FilterType {
        case alphabetical
        case industry
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    filterSection
                    customerListSection
                }
                .navigationTitle("🗃️ Kunden")
                .navigationBarTitleDisplayMode(.inline)
                .disabled(isShowingDetail)
            }
            .blur(radius: isShowingDetail ? 20 : 0)
            
            if isShowingDetail, let customer = selectedCustomer {
                CustomerDetailView(customer: customer, isShowingDetail: $isShowingDetail)
            }
        }
    }
    
    private var filterSection: some View {
        Section {
            Picker("Sortieren nach", selection: $selectedFilter) {
                Text("Alphabetisch").tag(FilterType.alphabetical)
                Text("Branche").tag(FilterType.industry)
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    private var customerListSection: some View {
        Group {
            if filteredCustomers.isEmpty {
                Text("Keine Kunden angelegt")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(filteredCustomers) { customer in
                        CustomerListCell(customer: customer)
                            .onTapGesture {
                                selectedCustomer = customer
                                isShowingDetail = true
                            }
                    }
                    .onDelete(perform: deleteCustomer)
                }
            }
        }
    }
    
    private var filteredCustomers: [Customer] {
        switch selectedFilter {
        case .alphabetical:
            return customers.sorted { $0.name < $1.name }
        case .industry:
            return customers.sorted { $0.industry.rawValue < $1.industry.rawValue }
        }
    }
    
    private func deleteCustomer(at offsets: IndexSet) {
        offsets.forEach { index in
            let customer = customers[index]
            customer.resources.forEach(modelContext.delete)
            customer.graphics.forEach(modelContext.delete)
            modelContext.delete(customer)
        }
    }
}

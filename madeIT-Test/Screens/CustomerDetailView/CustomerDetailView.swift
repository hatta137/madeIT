//
//  CustomerDetailView.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 24.07.24.
//

import SwiftUI

struct CustomerDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var customer: Customer
    @Binding var isShowingDetail: Bool
    @State private var isShowingEditView = false
    
    var backgroundColor: Color {
        colorScheme == .light ? Color(.systemBackground) : Color(.secondarySystemBackground)
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(customer.name)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
                
                HStack(spacing: 20) {
                    Image(systemName: "server.rack")
                    Text("\(customer.resources.count)")
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    ContactInfo(image: "person.crop.circle", info: customer.contactName)
                    ContactInfo(image: "phone",              info: customer.tel)
                    ContactInfo(image: "mail",               info: customer.email)
                    ContactInfo(image: "wrench.adjustable",  info: customer.industry.rawValue)
                    
                    Text(customer.address)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .padding()
                }
                
                Button("Bearbeiten") {
                    isShowingEditView = true
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $isShowingEditView) {
                    EditCustomerView(customer: $customer, isShowingEditView: $isShowingEditView)
                }
                
            }
            .frame(width: 300, height: 500)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(radius: 40)
            .overlay(Button {
                isShowingDetail = false
            } label: {
                XDismissButton()
            }, alignment: .topTrailing)
        }
    }
}

struct ContactInfo: View {
    
    let image: String
    let info: String
    
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .padding(.horizontal, 10)
            Text(info)
        }
        .padding(.bottom, 20)
        
    }
}


//#Preview {
//    CustomerDetailView(customer: Customer(name: "HL Web Dev", contactName: "Hendrik Lendeckel", tel: "015140244595", email: "hendrik@lendeckel.de", industry: "Webdevelopment", address: "Kurt-Beate-Straße 9, 99086 Erfurt"), isShowingDetail: .constant(true))
//}

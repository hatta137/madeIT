//
//  CustomerListCell.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

struct CustomerListCell: View {
    
    
    let customer: Customer
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(customer.name)
                .font(.title2)
                .fontWeight(.medium)
                .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Ansprechpartner: ")
                        .font(.footnote)
                    Text("Branche: ")
                        .font(.footnote)
                    Text("Telefon")
                        .font(.footnote)
                    Text("Email")
                        .font(.footnote)
                    
                }
                
                VStack(alignment: .leading) {
                    
                    Text(customer.contactName)
                        .font(.footnote)
                    Text(customer.industry)
                        .font(.footnote)
                    Text(customer.tel)
                        .font(.footnote)
                    Text(customer.email)
                        .font(.footnote)
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    CustomerListCell(customer: Cus)
//}

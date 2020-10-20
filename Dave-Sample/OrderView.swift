//
//  OrderView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order:Order
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("₩\(item.price)")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("주문하기")
                    }
                }
            }
            .navigationBarTitle("장바구니")
            .listStyle(GroupedListStyle())
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
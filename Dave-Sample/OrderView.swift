//
//  OrderView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import SwiftUI
import Datadive

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
                .onAppear {
                    let products = NSMutableArray.init()
                    for item:MenuItem in order.items {
                        let productProp = NSMutableDictionary.init()
                        productProp["product_id"] = item.id.uuidString
                        productProp["product_name"] = item.name
                        productProp["price"] = item.price
                        products.add(productProp)
                    }
                    let eventProp = NSMutableDictionary.init()
                    eventProp["products"] = products
                    eventProp["order_total_price"] = order.total
                    eventProp["order_total_count"] = order.items.count
                    Datadive.instance().logEvent("order_started", withEventProperties: eventProp as? [AnyHashable : Any])
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

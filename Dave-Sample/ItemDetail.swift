//
//  ItemDetail.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import SwiftUI
import Datadive

struct ItemDetail: View {
    @EnvironmentObject var order:Order
    var item: MenuItem
    var body: some View {
        VStack {
            Text(item.description).padding()
            Button("장바구니 넣기") {
                self.order.add(item: self.item)
                // ************************
                // * Datadive SDK 삽입 부분
                let eventProp = NSMutableDictionary.init()
                eventProp["itemid"] = 0
                Datadive.instance().logEvent("click_shoppingbag_in_product", withEventProperties: eventProp as? [AnyHashable : Any])
                // ************************
                
            }.font(.headline)
            Spacer()
        }
        .navigationBarTitle(item.name)
        .onAppear {    // viewDidAppear
            // ************************
            // * Datadive SDK 삽입 부분
            let eventProp = NSMutableDictionary.init()
            eventProp["itemid"] = 0
            eventProp["product_name"] = self.item.name
            eventProp["category_id"] = 0
            eventProp["category_name"] = 0
            eventProp["brand_id"] = 0
            eventProp["brand_name"] = 0
            eventProp["price"] = 0
            Datadive.instance().logEvent("view_product", withEventProperties: eventProp as? [AnyHashable : Any])
            // ************************
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example).environmentObject(order)
        }
    }
}

//
//  ItemDetail.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order:Order
    var item: MenuItem
    var body: some View {
        VStack {
            Text(item.description).padding()
            Button("장바구니 넣기") {
                self.order.add(item: self.item)
            }.font(.headline)
            Spacer()
        }
        .navigationBarTitle(item.name)
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

//
//  CheckoutView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/20.
//

import SwiftUI
import Datadive

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    static let paymentTypes = ["현금", "신용카드", "카카오페이"]
    
    @State private var showingPaymentAlert = false
    @State private var paymentType = 0
    @State private var addGiftcardDetails = false
    @State private var giftcardNumber = ""
    
    var body: some View {
        Form {
            Section {
                Picker("결제 수단을 선택해주세요.", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $addGiftcardDetails.animation()) {
                    Text("상품권 사용")
                }
                if addGiftcardDetails {
                    TextField("상품권 번호를 입력해주세요.", text: $giftcardNumber)
                }
            }
            
            Section(header: Text("TOTAL: ₩\(order.total)").font(.largeTitle)) {
                Button("결제") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("결제 완료"),
                  message: Text("₩\(order.total) – \(Self.paymentTypes[paymentType])"),
                  dismissButton: .default(Text("OK")) {
                    // ************************
                    // * Datadive SDK 삽입 부분
                    for item:MenuItem in order.items {
                        let revenue:DDRevenue = DDRevenue.init().setProductIdentifier(item.id.uuidString)
                        revenue.setQuantity(1)
                        revenue.setPrice(item.price as NSNumber)
                        let rEventProp = NSMutableDictionary.init()
                        rEventProp["order_id"] = order.order_id
                        rEventProp["product_name"] = item.name
                        revenue.setEventProperties(rEventProp as? [AnyHashable : Any])
                        Datadive.instance().logRevenueV2(revenue)
                    }
                    let eventProp = NSMutableDictionary.init()
                    eventProp["order_id"] = order.order_id
                    eventProp["payment_total_price"] = order.total
                    eventProp["payment_type"] = Self.paymentTypes[paymentType]
                    Datadive.instance().logEvent("order_complete", withEventProperties: eventProp as? [AnyHashable : Any])
                    // ************************
                    
                    order.removeAll()
                  }
            )
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}

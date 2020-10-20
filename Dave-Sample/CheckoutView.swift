//
//  CheckoutView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/20.
//

import SwiftUI

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

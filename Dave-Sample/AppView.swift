//
//  AppView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import SwiftUI
import Datadive

struct AppView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "d.circle.fill")
                    Text("상품")
                }

            OrderView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("장바구니")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
        }.onAppear {    // viewDidAppear
            // ************************
            // * Datadive SDK 삽입 부분
            Datadive.instance().logEvent("view_main")
            // ************************
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        AppView().environmentObject(order)
    }
}

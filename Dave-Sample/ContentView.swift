//
//  ContentView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import SwiftUI
import Datadive

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            ItemRow(item: item)
                        }
                    }
                }
            }
            .navigationBarTitle("Menu")
            .listStyle(GroupedListStyle())
        }.onAppear {    // viewDidAppear
            // ************************
            // * Datadive SDK 삽입 부분
            Datadive.instance().logEvent("view_product_list")
            // ************************
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

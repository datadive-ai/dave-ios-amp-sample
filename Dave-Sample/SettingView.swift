//
//  SettingView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/20.
//

import SwiftUI

struct SettingView: View {
    @State private var logedIn = false
    @State private var emailAddress = ""
    @State private var enabledIDFA = false
    
    var body: some View {
        Form {
            Section {
                TextField("이메일 주소를 입력해주세요.", text: $emailAddress)
                Text("")
                if logedIn {
//                    TextField("이메일 주소를 입력해주세요.", text: $emailAddress)
                }
            }
            
            Section(header: Text("설정")) {
                Toggle(isOn: $enabledIDFA.animation()) {
                    Text("IDFA 사용")
                }
                Toggle(isOn: $enabledIDFA.animation()) {
                    Text("위치 서비스 사용")
                }
            }
        }
        .navigationBarTitle(Text("Setting"), displayMode: .inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

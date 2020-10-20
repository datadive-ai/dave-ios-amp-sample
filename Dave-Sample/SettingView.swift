//
//  SettingView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/20.
//

import SwiftUI

struct SettingView: View {
    static let sexes = ["male", "female", "unknown"]
    static let grades = ["bronze", "silver", "gold", "diamond"]
    
    @State private var showingProfileAlert = false
    @State private var loggedIn = false
    @State private var sex = 0
    @State private var grade = 0
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $loggedIn.animation()) {
                    Text("로그인 여부")
                }
                if loggedIn {
                    Text("test_ios@mail.com 으로 로그인 되었습니다.").font(.footnote)
                }
            }
            
            if loggedIn {
                Section(header: Text("성별 / 회원등급")) {
                    Picker("성별", selection: $sex) {
                        ForEach(0 ..< Self.sexes.count) {
                            Text(Self.sexes[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Picker("회원등급", selection: $grade) {
                        ForEach(0 ..< Self.grades.count) {
                            Text(Self.grades[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button("프로필 업데이트") {
                        self.showingProfileAlert.toggle()
                    }
                }
            }
        }
        .navigationBarTitle(Text("Setting"), displayMode: .inline)
        .alert(isPresented: $showingProfileAlert) {
            Alert(title: Text("업데이트 완료"),
                  dismissButton: .default(Text("OK")) { }
            )
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

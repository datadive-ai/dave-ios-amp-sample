//
//  SettingView.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/20.
//

import SwiftUI
import Datadive

struct SettingView: View {
    static let sexes = ["male", "female", "unknown"]
    static let grades = ["bronze", "silver", "gold", "diamond"]
    
    @ObservedObject var userSetting = UserSettings()
    
    @State private var showingProfileAlert = false
//    @State private var loggedIn = false
//    @State private var sex = 0
//    @State private var grade = 0
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $userSetting.loggedIn.animation()) {
                    Text("로그인 여부")
                }
                if userSetting.loggedIn {
                    let email = "test_ios@mail.com"
                    Text("\(email) 으로 로그인 되었습니다.").font(.footnote)
                        .onAppear {
                            // ************************
                            // * Datadive SDK 삽입 부분
                            let userProp = NSMutableDictionary.init()
                            userProp["x_user_id"] = email
                            userProp["x_is_agreed"] = true
                            userProp["x_gender"] = "male"
                            userProp["x_grade"] = "bronze"
                            userProp["x_birthday"] = Calendar.current.date(byAdding: .year, value: -38, to: Date.init())
                            Datadive.instance().setUserProperties(userProp as! [AnyHashable : Any])
                            Datadive.instance().logEvent("response_login", withEventProperties: userProp as? [AnyHashable : Any])
                            Datadive.instance().setUserId(email, startNewSession: false)
                            // ************************
                        }
                        .onDisappear {
                            // ************************
                            // * Datadive SDK 삽입 부분
                            Datadive.instance().logEvent("sign_out")
                            Datadive.instance().clearUserProperties()
                            Datadive.instance().setUserId(nil, startNewSession: true)
                            // ************************
                        }
                }
            }
            
            if userSetting.loggedIn {
                Section(header: Text("성별 / 회원등급")) {
                    Picker("성별", selection: $userSetting.sex) {
                        ForEach(0 ..< Self.sexes.count) {
                            Text(Self.sexes[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Picker("회원등급", selection: $userSetting.grade) {
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
                  dismissButton: .default(Text("OK")) {
                    // ************************
                    // * Datadive SDK 삽입 부분
                    let userProp = NSMutableDictionary.init()
                    userProp["x_gender"] = Self.sexes[userSetting.sex]
                    userProp["x_grade"] = Self.grades[userSetting.grade]
                    Datadive.instance().setUserProperties(userProp as! [AnyHashable : Any])
                    // ************************
                  }
            )
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

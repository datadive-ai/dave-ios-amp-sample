//
//  UserSetting.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/21.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var loggedIn: Bool = UserDefaults.standard.bool(forKey: "loggedIn") {
        didSet { UserDefaults.standard.set(self.loggedIn, forKey: "loggedIn") }
    }

    @Published var sex: Int = UserDefaults.standard.integer(forKey: "sex") {
        didSet { UserDefaults.standard.set(self.sex, forKey: "sex") }
    }
    
    @Published var grade: Int = UserDefaults.standard.integer(forKey: "grade") {
        didSet { UserDefaults.standard.set(self.grade, forKey: "grade") }
    }
}

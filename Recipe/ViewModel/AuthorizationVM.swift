//
//  AuthorizationVM.swift
//  Recipe
//
//  Created by Akhrorkhuja on 09/05/22.
//

import Foundation
import SwiftUI

extension AuthorizationView {
    class AuthorizationVM: ObservableObject {
        @State var loginStatus = false
        private var authService = AuthService()
        func login() {
            let state = authService.signIn()
            switch state {
            case .signedIn:
                print("🟢 Signed in")
            case .signedOut:
                print("🔴 Signed out")
            }
            debugPrint(loginStatus)
        }
    }
}

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
        private var authService = AuthService()
        func signIn(completion: @escaping (Bool) -> Void) {
            authService.signIn { state in
                switch state {
                case .signedIn:
                    completion(true)
                case .signedOut:
                    completion(false)
                }
            }
        }
        func signOut(completion: @escaping (Bool) -> Void) {
            authService.signOut { state in
                switch state {
                case .signedIn:
                    completion(true)
                case .signedOut:
                    completion(false)
                }
            }
        }
    }
}

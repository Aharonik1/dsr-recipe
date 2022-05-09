//
//  AuthorizationVM.swift
//  Recipe
//
//  Created by Akhrorkhuja on 09/05/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

extension AuthorizationView {
    class AuthorizationVM: ObservableObject {
        func login(completion: @escaping (Bool) -> Void) {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                completion(false)
                return
            }
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
                completion(false)
                return
            }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { user, error in
                if let error = error {
                    print(error)
                    completion(false)
                    return
                }
                guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        print(error)
                        completion(false)
                        return
                    }
                    guard let user = result?.user else {
                        completion(false)
                        return
                    }
                    completion(true)
                    print(user.displayName ?? "Success")
                }
            }
        }
    }
}

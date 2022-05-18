//
//  AuthService.swift
//  Recipe
//
//  Created by Akhrorkhuja on 18/05/22.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Combine

enum SignInState {
    case signedIn
    case signedOut
}

typealias StateRes = (SignInState) -> Void

class AuthService: ObservableObject {
    private var resUser: GIDGoogleUser?
    private var state: SignInState = .signedOut
    func signIn(completion: @escaping StateRes) {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error) { _ in  }
                self.resUser = user
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                completion(state)
                return
            }
            let configuration = GIDConfiguration(clientID: clientID)
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
                completion(state)
                return
            }
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: presentingViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error) {_ in
                    completion(state)
                }
                self.resUser = user
            }
        }
        return
    }
    func signOut(completion: @escaping StateRes) {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
        completion(state)
        return
    }
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?, completion: @escaping StateRes) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
                completion(state)
            }
        }
    }
}

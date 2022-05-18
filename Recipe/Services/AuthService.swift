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

class AuthService: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    private var resUser: GIDGoogleUser?
    private var state: SignInState = .signedOut
    func signIn() -> SignInState {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                self.resUser = user
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return state }
            let configuration = GIDConfiguration(clientID: clientID)
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return state }
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: presentingViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                self.resUser = user
            }
        }
        return state
    }
    func signOut() -> SignInState {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
        return state
    }
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
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
            }
        }
    }
}

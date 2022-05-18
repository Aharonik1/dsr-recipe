//
//  AuthorizationView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI

struct AuthorizationView: View {
    @AppStorage("loginStatus") var loginStatus = false
    @StateObject private var authorizationVM = AuthorizationVM()
    var body: some View {
        VStack {
            Text("Sign in")
                .bold()
                .font(.title2)
                .padding()
            Button("with GOOGLE") {
                authorizationVM.signIn { status in
                    loginStatus = status
                }
            }
        }
        .navigationTitle("Authorization")
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}

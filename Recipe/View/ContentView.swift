//
//  ContentView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 26/04/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("loginStatus") var loginStatus = false
    var body: some View {
        if loginStatus {
            RecipesView()
        } else {
            AuthorizationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

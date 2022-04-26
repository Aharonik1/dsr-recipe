//
//  RecipeApp.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthorizationView()
            }
        }
    }
}

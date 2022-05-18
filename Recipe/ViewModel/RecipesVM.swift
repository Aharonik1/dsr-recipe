//
//  RecipesVM.swift
//  Recipe
//
//  Created by Akhrorkhuja on 05/05/22.
//

import Foundation
import RealmSwift
import FirebaseAuth
import GoogleSignIn

extension RecipesView {
    class RecipesVM: ObservableObject {
        @ObservedResults(Recipe.self, sortDescriptor: SortDescriptor.init(keyPath: "recipeTitle", ascending: true)) var recipesFetched
        private var authService = AuthService()
        func delete(at offsets: IndexSet) {
            $recipesFetched.remove(atOffsets: offsets)
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

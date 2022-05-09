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
        func delete(at offsets: IndexSet) {
            $recipesFetched.remove(atOffsets: offsets)
        }
        func signOut() -> Bool {
            GIDSignIn.sharedInstance.signOut()
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
                return false
            }
            return true
        }
    }
}

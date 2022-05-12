//
//  AddRecipeVM.swift
//  Recipe
//
//  Created by Akhrorkhuja on 06/05/22.
//

import Foundation
import RealmSwift

extension AddRecipeView {
    class AddRecipeVM: ObservableObject {
        @ObservedResults(Recipe.self, sortDescriptor: SortDescriptor.init(keyPath: "recipeTitle", ascending: true)) var recipesFetched
        @Published var title = ""
        @Published var description = ""
        @Published var recipeType: RecipeType = .healthy
        @Published var showingAlert = false
        func add(completion: @escaping (Bool) -> Void) {
            if title.isEmpty || description.isEmpty {
                showingAlert = true
                completion(false)
                return
            }
            let recipe = Recipe()
            recipe.recipeTitle = title
            recipe.recipeDesc = description
            recipe.recipeType = recipeType
            $recipesFetched.append(recipe)
            title.removeAll()
            description.removeAll()
            completion(true)
        }
    }
}

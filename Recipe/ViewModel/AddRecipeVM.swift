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
        func add(title: String, description: String, type: RecipeType) {
            let recipe = Recipe()
            recipe.recipeTitle = title
            recipe.recipeDesc = description
            recipe.recipeType = type
            $recipesFetched.append(recipe)
        }
    }
}

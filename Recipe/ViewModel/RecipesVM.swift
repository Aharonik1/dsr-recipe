//
//  RecipesVM.swift
//  Recipe
//
//  Created by Akhrorkhuja on 05/05/22.
//

import Foundation
import RealmSwift

extension RecipesView {
    class RecipesVM: ObservableObject {
        @ObservedResults(Recipe.self, sortDescriptor: SortDescriptor.init(keyPath: "recipeTitle", ascending: true)) var recipesFetched
        func delete(at offsets: IndexSet) {
            $recipesFetched.remove(atOffsets: offsets)
        }
    }
}

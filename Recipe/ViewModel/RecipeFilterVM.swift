//
//  RecipeFilterVM.swift
//  Recipe
//
//  Created by Akhrorkhuja on 18/05/22.
//

import Foundation
import RealmSwift

enum SortByType: String, PersistableEnum, CaseIterable {
    case byName = "by name"
    case byDate = "by date"
    var id: SortByType { self }
}

extension RecipeFilterView {
    class RecipeFilterVM: ObservableObject {
        @ObservedResults(Recipe.self) var recipes
        @Published var recipesData = [Recipe]()
        @Published var sortType: SortByType = .byDate
        @Published var sortByRecipeType: RecipeType = .all
        @Published var searchText = ""
        @Published var searchResults = [Recipe]()
        init() {
            recipes
                .sorted(byKeyPath: sortType == .byName ? "recipeTitle" : "recipeDate", ascending: true)
                .forEach { recipe in
                    recipesData.append(recipe)
                }
        }
        func searchByText() {
            recipesData = []
            if searchText.isEmpty {
                recipes.forEach { recipe in
                    recipesData.append(recipe)
                }
                return
            }
            recipes
                .filter("recipeTitle CONTAINS[c] %@", searchText)
                .forEach { recipe in
                    recipesData.append(recipe)
                }
        }
        func sortAndFilter() {
            recipesData = []
            switch sortType {
            case .byName:
                if !(sortByRecipeType == .all) {
                    recipes
                        .where { $0.recipeType == self.sortByRecipeType }
                        .sorted(byKeyPath: "recipeTitle", ascending: true)
                        .forEach { recipe in
                            recipesData.append(recipe)
                        }
                } else {
                    recipes
                        .sorted(byKeyPath: "recipeTitle", ascending: true)
                        .forEach { recipe in
                            recipesData.append(recipe)
                        }
                }
            case .byDate:
                if !(sortByRecipeType == .all) {
                    recipes
                        .where { $0.recipeType == self.sortByRecipeType }
                        .sorted(byKeyPath: "recipeDate", ascending: true)
                        .forEach { recipe in
                            recipesData.append(recipe)
                        }
                } else {
                    recipes
                        .sorted(byKeyPath: "recipeDate", ascending: true)
                        .forEach { recipe in
                            recipesData.append(recipe)
                        }
                }
            }
        }
    }
}

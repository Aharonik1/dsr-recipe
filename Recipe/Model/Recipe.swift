//
//  Recipe.swift
//  Recipe
//
//  Created by Akhrorkhuja on 28/04/22.
//

import SwiftUI
import RealmSwift

class Recipe: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var recipeTitle: String
    @Persisted var recipeDesc: String
    @Persisted var recipeType: RecipeType = .healthy
}

enum RecipeType: String, PersistableEnum, CaseIterable {
    case fastFood = "Fast food"
    case dessert = "Dessert"
    case salad = "Salad"
    case breakfast = "Breakfast"
    case healthy = "Healthy"
    var id: RecipeType { self }
}

//
//  RecipesView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI
import RealmSwift

struct RecipesView: View {
    @StateObject private var recipesVM = RecipesVM()
    @AppStorage("loginStatus") var loginStatus = true
    @ObservedResults(Recipe.self, sortDescriptor: SortDescriptor.init(keyPath: "recipeTitle", ascending: true)) var recipes
    var body: some View {
        NavigationView {
            ZStack {
                if recipes.isEmpty {
                    Text("Add new recipes!")
                } else {
                    List {
                        ForEach(recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRow(recipe: recipe)
                            }
                        }
                        .onDelete { offSet in
                            recipesVM.delete(at: offSet)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Log out") {
                        loginStatus = !recipesVM.signOut()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddRecipeView(), label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}

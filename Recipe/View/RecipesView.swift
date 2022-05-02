//
//  RecipesView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI
import RealmSwift

struct RecipesView: View {
    @ObservedResults(Recipe.self, sortDescriptor: SortDescriptor.init(keyPath: "recipeTitle", ascending: true)) var recipesFetched
    @State private var users = ["Paul", "Taylor", "Adele"]
    var body: some View {
        NavigationView {
            ZStack {
                if recipesFetched.isEmpty {
                    Text("Add new recipes")
                } else {
                    List {
                        ForEach(recipesFetched, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                HStack {
                                    AsyncImage(url: URL(string: "https://www.themealdb.com/images/media/meals/9ptx0a1565090843.jpg")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100, alignment: .center)
                                    } placeholder: {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100, alignment: .center)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(recipe.recipeTitle)
                                            .font(.headline)
                                        Text(recipe.recipeType.rawValue)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                NavigationLink(destination: AddRecipeView(), label: {
                        Image(systemName: "plus")
                })
            }
        }
        .navigationViewStyle(.stack)
    }
    func delete(at offsets: IndexSet) {
        $recipesFetched.remove(atOffsets: offsets)
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}

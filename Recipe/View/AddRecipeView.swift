//
//  AddRecipeView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI
import RealmSwift

struct AddRecipeView: View {
    @ObservedResults(Recipe.self) private var recipesFetched
    @State private var title = ""
    @State private var description = ""
    @State private var recipeType: RecipeType = .healthy
    @State private var showingAlert = false
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                ZStack(alignment: .leading) {
                    if description.isEmpty {
                        Text("Description")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.top, -5)
                    }
                    TextEditor(text: $description)
                        .padding(.leading, -3)
                }
                Picker("Choose recipe type", selection: $recipeType) {
                    ForEach(RecipeType.allCases, id: \.self) { recipe in
                        Text(recipe.rawValue)
                            .tag(recipe)
                    }
                }
            }
            Button("Add") {
                if title.isEmpty || description.isEmpty {
                    showingAlert = true
                    return
                }
                let recipe = Recipe()
                recipe.recipeTitle = title
                recipe.recipeDesc = description
                recipe.recipeType = recipeType
                $recipesFetched.append(recipe)
                title.removeAll()
                description.removeAll()
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Title or description is empty!"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Add recipe")
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}

//
//  AddRecipeView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var recipeType = "Fast food"
    let recipeTypes = ["Fast food", "Cake", "Homemade meal"]
    var body: some View {
        NavigationView {
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
                        ForEach(recipeTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Button("Add") {
                    //
                }
            }
            .navigationTitle("Add recipe")
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}

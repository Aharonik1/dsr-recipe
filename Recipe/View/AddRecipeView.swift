//
//  AddRecipeView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI
import RealmSwift

struct AddRecipeView: View {
    @StateObject private var addRecipeVM = AddRecipeVM()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $addRecipeVM.title)
                ZStack(alignment: .leading) {
                    if addRecipeVM.description.isEmpty {
                        Text("Description")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.top, -5)
                    }
                    TextEditor(text: $addRecipeVM.description)
                        .padding(.leading, -3)
                }
                Picker("Choose recipe type", selection: $addRecipeVM.recipeType) {
                    ForEach(RecipeType.allCases, id: \.self) { recipeType in
                        Text(recipeType.rawValue)
                            .tag(recipeType)
                    }
                }
            }
            Button("Add") {
                addRecipeVM.add { success in
                    if success {
                        self.mode.wrappedValue.dismiss()
                    }
                }
            }
            .alert(isPresented: $addRecipeVM.showingAlert) {
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

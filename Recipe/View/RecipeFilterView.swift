//
//  RecipeFilterView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 18/05/22.
//

import SwiftUI

struct RecipeFilterView: View {
    @StateObject private var recipeFilterVM = RecipeFilterVM()
    var body: some View {
        Form {
            Section {
                Picker("Choose sort type", selection: $recipeFilterVM.sortType) {
                    ForEach(SortByType.allCases, id: \.self) { sortByType in
                        Text(sortByType.rawValue)
                            .tag(sortByType)
                    }
                }
                .onChange(of: recipeFilterVM.sortType) { _ in
                    recipeFilterVM.sortAndFilter()
                }
                Picker("Filter recipe type", selection: $recipeFilterVM.sortByRecipeType) {
                    ForEach(RecipeType.allCases, id: \.self) { filterRecipeType in
                        Text(filterRecipeType.rawValue)
                            .tag(filterRecipeType)
                    }
                }
                .onChange(of: recipeFilterVM.sortByRecipeType) { _ in
                    recipeFilterVM.sortAndFilter()
                }
            }
            if recipeFilterVM.recipesData.isEmpty {
                Text("Nothing found!")
            } else {
                List {
                    ForEach(recipeFilterVM.recipesData, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
            }
        }
        .searchable(text: $recipeFilterVM.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: recipeFilterVM.searchText) { _ in
            recipeFilterVM.searchByText()
        }
        .navigationTitle("Sort & filter")
    }
}

struct RecipeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFilterView()
    }
}

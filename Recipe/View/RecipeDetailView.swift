//
//  RecipeDetailView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var recipe: Recipe
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "https://www.themealdb.com/images/media/meals/9ptx0a1565090843.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
            VStack {
                Text(recipe.recipeTitle)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(recipe.recipeType.rawValue)
                    .bold()
                Text(recipe.recipeDesc)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe())
    }
}

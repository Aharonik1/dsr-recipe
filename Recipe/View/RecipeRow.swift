//
//  RecipeRow.swift
//  Recipe
//
//  Created by Akhrorkhuja on 05/05/22.
//

import SwiftUI

struct RecipeRow: View {
    @State var recipe: Recipe
    var body: some View {
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
                Text(recipe.recipeDate.converToString)
                    .font(.subheadline)
                Text(recipe.recipeType.rawValue)
                    .font(.subheadline)
            }
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: Recipe())
    }
}

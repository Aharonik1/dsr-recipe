//
//  RecipeDetailView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var recipe: Recipe
    private let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
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

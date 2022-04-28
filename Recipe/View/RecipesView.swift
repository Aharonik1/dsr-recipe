//
//  RecipesView.swift
//  Recipe
//
//  Created by Akhrorkhuja on 25/04/22.
//

import SwiftUI

struct RecipesView: View {
    @State private var users = ["Paul", "Taylor", "Adele"]
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { _ in
                    NavigationLink(destination: RecipeDetailView()) {
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
                            Text("Portuguese custard tarts")
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Recipes")
        }
        .navigationViewStyle(.stack)
    }
    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}

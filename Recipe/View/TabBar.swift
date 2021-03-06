//
//  TabBar.swift
//  Recipe
//
//  Created by Akhrorkhuja on 26/04/22.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "house")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

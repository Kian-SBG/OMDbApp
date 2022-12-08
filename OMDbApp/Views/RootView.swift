//
//  RootView.swift
//  OMDbApp
//
//  Created by Kian Popat on 14/11/2022.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var favouritesService : FavouritesService
    
    var body: some View {
        TabView {
            ContentView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            FavouritesView().tabItem {
                Label("Favourites", systemImage: "star.fill")
            }
        }
        .environmentObject(FavouritesService())
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(FavouritesService())
    }
}

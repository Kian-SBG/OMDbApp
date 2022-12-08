//
//  OMDbAppApp.swift
//  OMDbApp
//
//  Created by Kian Popat on 26/10/2022.
//

import SwiftUI

@main
struct OMDbAppApp: App {
    
    @State var favouritesService = FavouritesService()
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(favouritesService)
        }
        
    }
}

//
//  Favourites.swift
//  OMDbApp
//
//  Created by Kian Popat on 09/11/2022.
//

import Foundation

class FavouritesService: ObservableObject{
    @Published var favouriteMovies = [String](){
        didSet{ //if favouriteMovies is set
            save()
        }
    }
    
    private let favouritesStorageKey = "Favourites"
    
    init() {

        let data = UserDefaults.standard.object(forKey: favouritesStorageKey)
        guard let favourites = data as? [String] else { return }//data should be an array of strings
        self.favouriteMovies = favourites
    }
    
    func contains(_ movieID: String) -> Bool{
        favouriteMovies.contains(movieID)
    }
    
    func add(_ movieID: String){
        favouriteMovies.append(movieID)
    }
    
    func remove(_ movieID: String){
        if let index = favouriteMovies.firstIndex(of: movieID) {
          favouriteMovies.remove(at: index)
        }
        //favouriteMovies.(movieID)
    }
    
    func removeAll(){
        favouriteMovies.removeAll()
    }
    
    func save(){
        UserDefaults.standard.set(favouriteMovies, forKey: favouritesStorageKey)
    }
    
}

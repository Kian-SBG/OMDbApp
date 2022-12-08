//
//  FavouritesView.swift
//  OMDbApp
//
//  Created by Kian Popat on 14/11/2022.
//

import SwiftUI

/// The view that displays the favourites
///
/// Requries Environment Object FavouritesService
struct FavouritesView: View {
    
    @EnvironmentObject var favouritesService: FavouritesService //Data will be shared across apps
    @EnvironmentObject var favourites : FavouritesService
    @State private var movies: [MovieData] = []
    
    
    var body: some View {
        NavigationStack {
            List(movies) { movie in //Show in list, movies with id - imdbID
                NavigationLink {
                    MovieDetailView(movieID: movie.imdbID) //Takes you to movie detail view
                } label: {
                    MovieCell(movie: movie) //List displays movie cell view in each list item
                }
                Button(favourites.contains(movie.imdbID) ? "Remove from favourites" : "Add to favourites"){
                    if favourites.contains(movie.imdbID) {
                        favourites.remove(movie.imdbID)
                    } else {
                        favourites.add(movie.imdbID)
                    }
                }
            }
            .navigationTitle("Favourites")
        }
        .onReceive(favouritesService.$favouriteMovies) { //When data from favourites service is detected
            mapNewFavourites($0)
        }
    }
    
    private func mapNewFavourites(_ newFavourites: [String]) {
        Task {
            movies = try await newFavourites.asyncMap({ movieId in
                try await Webservice().getMovie(withId: movieId)
            }) //map favourite movie to movies array
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environmentObject(FavouritesService())
    }
}

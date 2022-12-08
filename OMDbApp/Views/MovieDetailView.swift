//
//  MovieDetail.swift
//  OMDbApp
//
//  Created by Kian Popat on 08/11/2022.
//

import SwiftUI

/// View for details of only one movie
struct MovieDetailView: View {
    
    var movieID: String //create movie of type MovieData
    
    @StateObject var movieDetailsViewModel: MovieDetailsViewModel = MovieDetailsViewModel()
    
    var body: some View {
        Text(movieDetailsViewModel.detailedMovie?.title ?? "No Title Found")
        Text(movieDetailsViewModel.detailedMovie?.plot ?? "No plot found")
        Text(movieDetailsViewModel.detailedMovie?.actors ?? "No actors found")
            .task {
                await movieDetailsViewModel.getDetail(movieID)
            }
        
        
    }
    
    
    
    
}

@MainActor
class MovieDetailsViewModel: ObservableObject {
    
    @Published var detailedMovie: MovieData?
    
    func getDetail(_ movieID: String) async {
        do{
            self.detailedMovie = try await Webservice().getMovie(withId: movieID)
        }
        catch{
        }
        print(detailedMovie)
    }
    
    init() {}
}





//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        //MovieDetailView(movie: MovieData(imdbID: "123", title: "movie1", type: "big movie", year: "2022"))
//    }
//}

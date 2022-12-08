//
//  ContentView.swift
//  OMDbApp
//
//  Created by Kian Popat on 26/10/2022.
//

import SwiftUI

extension ContentView{
    class ViewModel: ObservableObject{
        
        @Published var searchedMovies:[MovieData] = []
        
        @Published var searchTerm: String = ""  //@published observable objects that automatically announce when changes occur
        @Published var searchHistory: [String] = []
        
        func insertIntoArray(_ value: String, array: [String]) -> [String]{
            var arr = array //create a temporary changable array
            if arr.contains(value){ //if array contains value
                let index = arr.firstIndex(of: value)! //grab the index
                arr.remove(at: index) //remove value at the index
            }
            if arr.count >= 5{ //if size of array is >5
                arr.removeFirst() //remove the first element
            }
            arr.append(value) //add element to end of array
            return arr
        }
        
        init() {
            //read from user defaults
            let data = UserDefaults.standard.object(forKey: "searchHistory")
            guard let history = data as? [String] else { return }//data should be an array of strings
            self.searchHistory = history //update search history
            
        }
        
        func performSearch() {
            print("Search term: \(searchTerm)")
            searchHistory = insertIntoArray(searchTerm, array: searchHistory)
            
            //write to userDefaults, with standard settings, as on object, key is "searchhistory"
            UserDefaults.standard.set(searchHistory, forKey: "searchHistory")
            
            Task { //A unit of asyncronous work
                do {
                    let movies = try await Webservice().performSearch(searchTerm) //movies = async function perform search
                    self.searchedMovies = movies
                } catch {
                    print("Webservice().performSearch(\(searchTerm) failed")
                }
            }
            
        }
    }
}



struct ContentView: View {
    
    //    @ObservedObject var viewModel = ViewModel()
    @EnvironmentObject var favourites : FavouritesService
    
    
    private var searchHistoryService = SearchHistoryService()
    
    @State private var movies: [MovieData] = []
    @State private var searchTerm: String = ""
    
    // @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List(movies, id: \.imdbID){ movie in //Show in list, movies with id - imdbID
                NavigationLink { //
                    MovieDetailView(movieID: movie.imdbID) //Takes you to movie detail view
                } label: {
                    MovieCell(movie: movie) //List displays movie cell view in each list item
                }
                Button(favourites.contains(movie.imdbID) ? "Remove from favourites" : "Add to favourites"){
                    if favourites.contains(movie.imdbID){
                        favourites.remove(movie.imdbID)
                    } else {
                        favourites.add(movie.imdbID)
                    }
                }
            }
            .searchable(text: $searchTerm, prompt: Text("Find films"))  {
                ForEach(searchHistoryService.searchHistory, id: \.self) { history in
                    Text(history)
                        .searchCompletion(history)
                }
            }
            .onSubmit(of: .search, performSearch)
            .navigationTitle("Search")
        }
    }
    
    func performSearch() {
        searchHistoryService.add(term: searchTerm)
        Task {
            do {
                let movies = try await Webservice().performSearch(searchTerm)
                self.movies = movies
            } catch {
                print("Webservice().performSearch(\(searchTerm) failed")
            }
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FavouritesService())
    }
}

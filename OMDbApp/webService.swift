//
//  File.swift
//  OMDbApp
//
//  Created by Kian Popat on 27/10/2022.
//

import Foundation

class Webservice {
    
    private var urlComponents: URLComponents {
        var components = URLComponents() //using url components for the url
        components.scheme = "https"
        components.host = "www.omdbapi.com"
        components.queryItems = [ //adds query items to url
            URLQueryItem(name: "apikey", value: "13522c02" ) //adds apikey="___" to url
        ]
        return components
    }
    
    func performSearch(_ searchTerm: String) async throws -> [MovieData] { //performSearch is async
        print("perform search")
        var components = urlComponents
        components.queryItems?.append(
            URLQueryItem(name: "s", value: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)) //adds s="searchTerm" without whitespaces to the url
        )
        
        guard let url = components.url else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url) //data = async URLSession func
            
            //tried putting array here but didn't work
            if let decodedResponse = try? JSONDecoder().decode(SearchResult.self, from: data) { //decode to search result type
                return decodedResponse.moviesSearched
                
                //getMovie(withId: decodedResponse.imdbID)
            }

        } catch {
            throw error
        }
        
        
        return []
    }
    
    func getMovie(withId movieId: String) async throws -> MovieData {
        var components = urlComponents
        components.queryItems?.append(
            URLQueryItem(name: "i", value: movieId) //id query
        )
        
        guard let url = components.url else { throw  WebServiceError.URLnotFound}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MovieData.self, from: data) { //decode to movieDATA type
                return decodedResponse
            }
        } catch {
            throw error
        }
        
        
        throw WebServiceError.unknown
    }
    
}

enum WebServiceError: Error{
    
    case unknown
    case URLnotFound
    
}

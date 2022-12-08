//
//  MovieData.swift
//  OMDbApp
//
//  Created by Kian Popat on 07/11/2022.
//

import Foundation


//Decoable can convert from json to swft obj
struct MovieData: Decodable, Identifiable {
    var id: String {
        return imdbID
    }
    
    let imdbID: String
    let title: String
    let type: String
    let year: String

    let plot: String?
    let genre: String?
    let actors: String?

    
    private enum CodingKeys: String, CodingKey { //changing API json keys to better ones
        case imdbID = "imdbID"
        case title = "Title"
        case type = "Type"
        case year = "Year"

        case plot = "Plot"
        case genre = "Genre"
        case actors = "Actors"
    }
}

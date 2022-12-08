//
//  SearchResult.swift
//  OMDbApp
//
//  Created by Kian Popat on 07/11/2022.
//

import Foundation

struct SearchResult: Decodable {
    let moviesSearched: [MovieData]
    
    private enum CodingKeys: String, CodingKey{ //changing API json keys to better ones
        case moviesSearched = "Search"

    }
}

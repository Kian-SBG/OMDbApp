//
//  SearchHistoryService.swift
//  OMDbApp
//
//  Created by Kian Popat on 16/11/2022.
//

import Foundation

class SearchHistoryService {
    
    private(set) var searchHistory: [String] = [] {
        didSet {
            UserDefaults.standard.set(searchHistory, forKey: searchHistoryStorageKey)
        }
    }
    
    private let searchHistoryStorageKey = "SearchHistory"
    
    
    init() {
        let data = UserDefaults.standard.object(forKey: searchHistoryStorageKey)
        guard let history = data as? [String] else { return }//data should be an array of strings
        self.searchHistory = history
    }
    
    func add(term searchTerm: String) {
        if searchHistory.count > 5 {
            searchHistory.remove(at: 0)
        }
        if let index = searchHistory.firstIndex(of: searchTerm){
            searchHistory.remove(at: index)
        }
        searchHistory.append(searchTerm)
    }
    
}

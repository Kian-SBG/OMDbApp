//
//  SwiftUIView.swift
//  OMDbApp
//
//  Created by Kian Popat on 08/11/2022.
//

import SwiftUI

struct MovieCell: View {
    
    var movie: MovieData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.title)
            Text("Type: "+movie.type)
            Text("Year: "+movie.year)
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            //MovieCell(movie: MovieData(imdbID: "123", title: "movie1", type: "big movie", year: "2022"))
        }
    }
}

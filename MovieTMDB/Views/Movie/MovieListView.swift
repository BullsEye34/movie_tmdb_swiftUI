//
//  MovieListView.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 20/10/23.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView {
            ForEach(movies.indices, id: \.self){index in
                VStack{
                    if( index == 0 ){
                        Spacer()
                            .frame(height: 20.0)
                    }
                        MovieCard(movie: movies[index])
                }
            }
        }
    }
}

#Preview {
    MovieListView(movies: [Movie(id: 0, title: "Title", poster_path: "/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg", vote_average: 8.908765, overview: "Some description")])
}

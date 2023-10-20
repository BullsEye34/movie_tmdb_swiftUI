//
//  ContentView.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    var body: some View {
        VStack{
            switch(viewModel.movieState){
            case .idle: Text("Starting")
            case .loading: ProgressView()
            case .error(message: let message): Text("Error: \(message)")
            case .trendingMovies(let movies): ScrollView {
                ForEach(movies){ trendingMovie in
                    Text(trendingMovie.title)
                }
            }
            }
        }
        .padding()
        .onAppear{
            viewModel.getTrending()
        }
    }
    
    
}

#Preview {
    ContentView()
}

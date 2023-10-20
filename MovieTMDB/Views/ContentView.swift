//
//  ContentView.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    @State var searchText: String = ""
    var body: some View {
        NavigationStack{
            VStack{
                switch(viewModel.trendingMovieState){
                case .idle: Text("Starting")
                case .loading: ProgressView()
                case .error(message: let message): Text("Error: \(message)")
                case .trendingMovies(let movies):
                    MovieListView(movies: movies)
                case .searchedMovies(let movies):
                    MovieListView(movies: movies)
                }
            }
            .onAppear{
                viewModel.getTrending()
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { oldValue, newValue in
            if(newValue.count>3) {
                viewModel.getSearchedList(searchTerm: newValue)
            }
            if(newValue.count==0){
                viewModel.getTrending()
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}

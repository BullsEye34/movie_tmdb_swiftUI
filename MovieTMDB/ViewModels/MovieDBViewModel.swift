//
//  MovieDBViewModel.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 19/10/23.
//

import Foundation

@MainActor
class MovieDBViewModel:ObservableObject{
    enum MovieState{
        case idle
        case loading
        case error(message:String)
        case trendingMovies([Movie])
        case searchedMovies([Movie])
    }
    @Published var trendingMovieState = MovieState.idle
    
    func getTrending(){
        trendingMovieState = MovieState.loading
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")
            var urlRequest = URLRequest(url: url!)
            urlRequest.addValue("Bearer "+authToken, forHTTPHeaderField: "Authorization")
            do{
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let parsedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                trendingMovieState = MovieState.trendingMovies(parsedResponse.results)
            }catch{
                trendingMovieState = MovieState.error(message: error.localizedDescription)
                print(error)
            }

        }
    }
    
    func getSearchedList(searchTerm: String){
        trendingMovieState = MovieState.loading
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(searchTerm)&include_adult=true&language=en-US&page=1")
            var urlRequest = URLRequest(url: url!)
            urlRequest.addValue("Bearer "+authToken, forHTTPHeaderField: "Authorization")
            do{
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let parsedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                trendingMovieState = MovieState.searchedMovies(parsedResponse.results)
            }catch{
                trendingMovieState = MovieState.error(message: error.localizedDescription)
                print(error)
            }

        }
    }
}

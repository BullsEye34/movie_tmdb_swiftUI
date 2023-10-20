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
    }
    @Published var movieState = MovieState.idle
    
    func getTrending(){
        movieState = MovieState.loading
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")
            var urlRequest = URLRequest(url: url!)
            urlRequest.addValue("Bearer "+authToken, forHTTPHeaderField: "Authorization")
            do{
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let parsedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                movieState = MovieState.trendingMovies(parsedResponse.results)
            }catch{
                movieState = MovieState.error(message: error.localizedDescription)
                print(error)
            }

        }
    }
}

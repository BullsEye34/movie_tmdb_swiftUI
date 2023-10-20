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
    
    enum CreditsState{
        case idle
        case loading
        case error(message:String)
        case credits(CreditsResponse)
    }
    @Published var trendingMovieState = MovieState.idle
    @Published var creditsState = CreditsState.idle
    
    func getTrending(){
        trendingMovieState = MovieState.loading
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")
            var urlRequest = URLRequest(url: url!)
            urlRequest.addValue("Bearer "+authToken, forHTTPHeaderField: "Authorization")
            do{
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    let parsedResponse = try JSONDecoder().decode(TrendingAndSearchResponse.self, from: data)
                    trendingMovieState = MovieState.trendingMovies(parsedResponse.results)
                }else{
                    trendingMovieState = MovieState.error(message: ((try? JSONSerialization.jsonObject(with: data, options: []))as? [String: Any])!["status_message"] as! String)
                }
                
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
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    let parsedResponse = try JSONDecoder().decode(TrendingAndSearchResponse.self, from: data)
                    trendingMovieState = MovieState.searchedMovies(parsedResponse.results)
                }else{
                    trendingMovieState = MovieState.error(message: ((try? JSONSerialization.jsonObject(with: data, options: []))as? [String: Any])!["status_message"] as! String)
                }
            }catch{
                trendingMovieState = MovieState.error(message: error.localizedDescription)
                print(error)
            }

        }
    }
    
    func getMovieDetails(movieID: Int){
        creditsState = CreditsState.loading
        Task{
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?language=en-US")
            var urlRequest = URLRequest(url: url!)
            urlRequest.addValue("Bearer "+authToken, forHTTPHeaderField: "Authorization")
            do{
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    let parsedResponse = try JSONDecoder().decode(CreditsResponse.self, from: data)
                    creditsState = CreditsState.credits(parsedResponse)
                }else{
                    creditsState = CreditsState.error(message: ((try? JSONSerialization.jsonObject(with: data, options: []))as? [String: Any])!["status_message"] as! String)
                }
            }catch{
                creditsState = CreditsState.error(message: error.localizedDescription)
                print(error)
            }

        }
    }
}


//https://www.themoviedb.org/movie/872585-oppenheimer

//
//  TrendingAndSearchResponse.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 19/10/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendingAndSearchResponse = try? JSONDecoder().decode(TrendingAndSearchResponse.self, from: jsonData)

// MARK: - TrendingAndSearchResponse
struct TrendingAndSearchResponse : Decodable{
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}

// MARK: - Movie
struct Movie: Identifiable, Decodable{
    var id: Int
    var title: String
    var poster_path: String?
    var vote_average: Float
    var overview: String
    
    var posterURL: URL{
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w300")!
        return baseURL.appending(path: poster_path ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
    }
}

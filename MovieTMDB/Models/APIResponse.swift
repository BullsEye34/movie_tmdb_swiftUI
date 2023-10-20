//
//  APIResponse.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 19/10/23.
//

import Foundation

struct APIResponse : Decodable{
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}

struct Movie: Identifiable, Decodable{
    var id: Int
    var title: String
    var poster_path: String
    var vote_average: Float
    var overview: String
}

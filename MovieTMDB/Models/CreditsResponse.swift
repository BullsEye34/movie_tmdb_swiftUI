//
//  MovieDetailsResponse.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 20/10/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let creditsResponse = try? JSONDecoder().decode(CreditsResponse.self, from: jsonData)

// MARK: - CreditsResponse
struct CreditsResponse: Decodable {
    let cast: [Cast]
    let crew: [Cast]
}

// MARK: - Cast
struct Cast: Identifiable, Decodable {
    let gender, id: Int
    let name: String
    let profile_path: String?
    let character: String?
    let order: Int?
    let job: String?
    
    var imageURL: URL{
        let baseURL = URL(string: "https://image.tmdb.org/t/p/original/")!
        return baseURL.appending(path: profile_path ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
    }
}

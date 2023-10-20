//
//  MovieCard.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 20/10/23.
//

import SwiftUI

struct MovieCard: View {
    var movie: Movie
    var body: some View {
        HStack{
            Spacer()
                .frame(width: 20)
            ZStack (alignment: .leading) {
                HStack{
                    Spacer()
                        .frame(width: 120)
                    
                    VStack (alignment: .leading){
                        Text(movie.title)
                            .font(.title)
                        Spacer()
                            .frame(height: 2.0)
                        Text(movie.overview)
                            .font(.subheadline)
                            .lineLimit(3)
                        Spacer()
                            .frame(height: 10.0)
                        HStack{
                            Image(systemName: "hand.thumbsup.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.2f", movie.vote_average))
                                .font(.callout)
                                .foregroundColor(.yellow)
                        }
                    }
                    Spacer()
                }
                ZStack{
                    Rectangle()
                        .cornerRadius(10)
                        .shadow(radius: 16, y: 0)
                    AsyncImage(url: movie.posterURL){image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 150)
            }
            Spacer()
                .frame(width: 20)
        }
    }
}

//
//  MovieDetailsView.swift
//  MovieTMDB
//
//  Created by P Vamshi Prasad on 20/10/23.
//

import SwiftUI

struct MovieDetailsView: View {
    @Environment(\.openURL) var openURL
    let movie: Movie
    @StateObject var viewModel = MovieDBViewModel()
    var body: some View {
        ScrollView{
            AsyncImage(url: movie.posterURL){image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
            } placeholder: {
                ProgressView()
                    .frame(height: 700)
            }
            .frame(height: 700)
            VStack(alignment: .leading){
                HStack{
                    Text(movie.title)
                        .font(.title)
                    Spacer()
                    HStack{
                        Image(systemName: "hand.thumbsup.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.2f", movie.vote_average))
                            .font(.callout)
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.horizontal, 25.0)
                Spacer()
                    .frame(height: 15.0)
                Text(movie.overview)
                    .font(.callout)
                    .padding(.horizontal, 25.0)
                Spacer()
                    .frame(height: 30.0)
                
                switch(viewModel.creditsState){
                case .idle: Text("Starting")
                case .loading: ProgressView()
                case .error(message: _):
                    Spacer()
                        .frame(height: 30.0)
                case .credits(let credits):
                    VStack(alignment: .leading){
                        Text("Cast")
                            .font(.title)
                            .padding(.horizontal, 25.0)
                        Spacer()
                            .frame(height: 10.0)
                        ScrollView(.horizontal, showsIndicators: false){
                            let imageSize = 72.0
                            //https://www.themoviedb.org/person/
                            HStack{
                                ForEach(credits.cast.indices, id: \.self){index in
                                    if(index == 0){
                                            Spacer()
                                            .frame(width: 25.0)
                                    }
                                    Button(action: {
                                        openURL(URL(string: "https://www.themoviedb.org/person/\(credits.cast[index].id)")!)
                                    }, label: {
                                        VStack{
                                            AsyncImage(url: credits.cast[index].imageURL){image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(height: imageSize)
                                            }
                                            .frame(width: imageSize, height: imageSize)
                                            .cornerRadius(500.0)
                                            
                                        Spacer()
                                                .frame(height: 5.0)
                                            Text(credits.cast[index].name)
                                                .font(.title3)
                                                .lineLimit(1)
                                            
                                            
                                        Spacer()
                                                .frame(height: 5.0)
                                            Text(credits.cast[index].character ?? "Cast")
                                                .font(.title3)
                                                .lineLimit(1)
                                                .foregroundColor(.black.opacity(0.4))
                                        }
                                        .frame(width: 150)
                                    })
                                }
                            }
                        }
                        Spacer()
                            .frame(height: 25.0)
                        
                        
                        Text("Crew")
                            .font(.title)
                            .padding(.horizontal, 25.0)
                        Spacer()
                            .frame(height: 10.0)
                        ScrollView(.horizontal, showsIndicators: false){
                            let imageSize = 72.0
                            HStack{
                                ForEach(credits.crew.indices, id: \.self){index in
                                    if(index == 0){
                                            Spacer()
                                            .frame(width: 25.0)
                                    }
                                    Button(action: {
                                            openURL(URL(string: "https://www.themoviedb.org/person/\(credits.crew[index].id)")!)
                                    }, label: {
                                        VStack{
                                            AsyncImage(url: credits.crew[index].imageURL){image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(height: imageSize)
                                            }
                                            .frame(width: imageSize, height: imageSize)
                                            .cornerRadius(500.0)
                                            
                                        Spacer()
                                                .frame(height: 5.0)
                                            Text(credits.crew[index].name)
                                                .font(.title3)
                                                .lineLimit(1)
                                            
                                            
                                        Spacer()
                                                .frame(height: 5.0)
                                            Text(credits.crew[index].job ?? "Crew")
                                                .font(.title3)
                                                .lineLimit(1)
                                                .foregroundColor(.black.opacity(0.4))
                                        }
                                        .frame(width: 150)
                                    })
                                }
                            }
                        }
                    }
                }
                
                
                Spacer()
                    .frame(height: 32.0)
                HStack{
                    Spacer()
                    Button(action: {
                        openURL(URL(string: "https://www.themoviedb.org/movie/\(movie.id)")!)
                    }, label: {
                        Text("Open on TMDB Website")
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    Spacer()
                }
                

                
                Spacer()
                    .frame(height: 32.0)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear{
            viewModel.getMovieDetails(movieID: movie.id)
        }
    }
}

#Preview {
    MovieDetailsView(movie: Movie(id: 934433, title: "Title", poster_path: "/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg", vote_average: 8.908765, overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
}

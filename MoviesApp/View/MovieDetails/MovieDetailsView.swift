//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Mohamed Ayman on 12/11/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieID: Int
    @State private var movie: MovieInfo!
    let networkManager = NetworkManager()
    
    var body: some View {
        if movie == nil {
            ProgressView()
                .scaleEffect(2)
                .navigationTitle("Details")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    Task {
                        do {
                            self.movie = try await networkManager.fetchMovieDetails(id: movieID)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
        } else {
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w342\(movie.backdropPath)")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(16)
                        case .failure:
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.red)
                        @unknown default:
                            EmptyView()
                        }
                    }
//                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.width * 0.95 * 9/16)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.title.bold())
                            .fixedSize(horizontal: false, vertical: true)
                        if movie.tagline != "" {
                            Text(movie.tagline)
                                .font(.title3.bold())
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Text(String(describing: movie.genres.map{$0.name}.joined(separator: " - ")))
                        Text(movie.budget == 0 ? "Unknown Budget" : "Budget: \(movie.budget)")
                        Text(movie.revenue == 0 ? "Unknown Revenue" : "Revenue: \(movie.revenue.formatted())")
                        Text("Release Date: \(movie.releaseDate)")
                            .font(.headline)
                            .foregroundStyle(.gray)
                        Text(String(format: "★ %.1f    Total Votes: %d", movie.voteAverage, movie.voteCount))
                            .font(.headline)
                            .foregroundStyle(.gray)
//                        Text("Popularity: \(movie.popularity.formatted())")
                            .foregroundStyle(.blue)
//                        Text(String( movie.spokenLanguages.map{$0.name}.joined(separator: " - ")))
                        Text("Overview")
                            .padding(.top)
                        Text(movie.overview)
                            .font(.subheadline)
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding(.bottom)
                .frame(width: UIScreen.main.bounds.width/*, height: UIScreen.main.bounds.height * 0.9*/)
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieDetailsView(movieID: 923667)
}

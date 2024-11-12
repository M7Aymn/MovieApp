//
//  MoviesView.swift
//  MoviesApp
//
//  Created by Mohamed Ayman on 12/11/2024.
//

import SwiftUI

struct MoviesView: View {
    let category: TMDBAPI
    private let networkManager = NetworkManager()
    @State private var movies = [Movie]()
    var body: some View {
        NavigationStack {
            if movies.isEmpty {
                ProgressView()
                    .scaleEffect(2)
                    .navigationTitle("Now Playing")
            } else {
                List(movies.indices, id: \.self) { index in
                    NavigationLink(destination: Text("Details")) {
                        HStack(spacing: 20) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w342\(movies[index].posterPath)")) { phase in
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
                            .frame(width: UIScreen.main.bounds.width * 0.3, height: 180)
                            
                            VStack(alignment: .leading) {
                                Text(movies[index].title)
                                    .font(.title2.bold())
                                Text(movies[index].releaseDate)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                Text(String(format: "★ %.1f", movies[index].voteAverage))
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                .navigationTitle(category.title)
            }
        }
        .onAppear {
            Task {
                do {
                    self.movies = try await networkManager.fetchMovies(category: category).results
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    MoviesView(category: .nowPlaying)
}

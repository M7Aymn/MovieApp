//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Mohamed Ayman on 12/11/2024.
//

import Foundation

enum MovieError: LocalizedError {
    case badURL
    case badResponse
}

class NetworkManager {
    func fetchMovies(category: TMDBAPI) async throws -> Movies {
        guard let url = URL(string: category.urlString) else { throw MovieError.badURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MovieError.badResponse }
        return try JSONDecoder().decode(Movies.self, from: data)
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieInfo {
        let url = "https://api.themoviedb.org/3/movie/\(id)?language=en-US&api_key=30dafbee1b24fdef15b88ce161deecc2"
        guard let url = URL(string: url) else { throw MovieError.badURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MovieError.badResponse }
        return try JSONDecoder().decode(MovieInfo.self, from: data)
    }
    
    func fetchImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MovieError.badResponse }
        return data
    }
}

//
//  TMDBAPI.swift
//  MoviesApp
//
//  Created by Mohamed Ayman on 12/11/2024.
//

import Foundation

enum TMDBAPI {
    private static let baseURL = "https://api.themoviedb.org/3/movie"
    private static let apiKey = "2336fd0db65dd86e91bbdb01ac1a45ee"

    case nowPlaying
    case popular
    case upcoming
        
    private var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .popular:
            return "/popular"
        case .upcoming:
            return "/upcoming"
        }
    }
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    var urlString: String {
        return TMDBAPI.baseURL + self.path + "?api_key=" + TMDBAPI.apiKey
    }
}

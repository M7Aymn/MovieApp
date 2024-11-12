//
//  ContentView.swift
//  MoviesApp
//
//  Created by Mohamed Ayman on 12/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoviesView(category: .nowPlaying)
                .tabItem {
                    Label(TMDBAPI.nowPlaying.title, systemImage: "play.fill")
                }
            
            MoviesView(category: .popular)
                .tabItem {
                    Label(TMDBAPI.popular.title, systemImage: "flame.fill")
                }
            
            MoviesView(category: .upcoming)
                .tabItem {
                    Label(TMDBAPI.upcoming.title, systemImage: "square.and.pencil")
                }
        }
        .tint(Color(red: 119/255, green: 16/255, blue: 35/255))
    }
}

#Preview {
    ContentView()
}

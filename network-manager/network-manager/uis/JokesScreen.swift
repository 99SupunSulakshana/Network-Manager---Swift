//
//  JokesScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct JokesScreen: View {
    @State private var jokes: [Joke]? = nil
    let manager = NetworkManager.shared
    var body: some View {
        Group {
            if let jokes {
                List(jokes.shuffled()) { joke in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(joke.setup)
                            .font(.headline)
                        Text(joke.punchline)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No Jokes available", systemImage: "hand.thumbsdown.fill")
            }
        }
        .task {
            jokes = await manager.fetchAndDecodeJSON(from: TestURL.jokesURL)
        }
    }
}

#Preview {
    NavigationStack {
        JokesScreen()
            .navigationTitle(ViewOption.second.title)
            .toolbarTitleDisplayMode(.inlineLarge)
    }
}

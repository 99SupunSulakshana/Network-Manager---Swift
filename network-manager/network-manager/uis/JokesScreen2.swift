//
//  JokesScreen2.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//
import SwiftUI

struct JokesScreen2 : View {
    @State private var jokes: [Joke2]? = nil
    var body: some View {
        Group {
            if let jokes {
                List(jokes.shuffled()) { joke in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(joke.setup)
                            .font(.headline)
                        Text(joke.punchline)
                        Text(joke.entryDate, format: .dateTime.month().day().year())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No Jokes available", systemImage: "hand.thumbsdown.fill")
            }
        }
    }
}

#Preview {
    NavigationStack {
        JokesScreen2()
            .navigationTitle(ViewOption.fourth.title)
            .toolbarTitleDisplayMode(.inlineLarge)
    }
}

//
//  JokesScreen2.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//
import SwiftUI

struct JokesScreen2 : View {
    @State private var viewModel = DataViewModel<[Joke2]>(url: TestURL.jokesURL){
        decoder in
        decoder.dateDecodingStrategy = .iso8601
    }
    
    var body: some View {
        Group {
            if let jokes = viewModel.data, !jokes.isEmpty {
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
                .refreshable {
                    Task{
                        await viewModel.fetchData()
                    }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No Jokes available", systemImage: "hand.thumbsdown.fill")
            }
        }
        .withLoader(isLoading: viewModel.isLoading, title: "Jokes")
        .task {
            await viewModel.fetchData()
        }
        .alert(
            "Unable to load jokes.",
            isPresented: Binding(get: {
                viewModel.networkManagerError != nil
            }, set: { value in
                if !value { viewModel.networkManagerError = nil}
            }),
            presenting: viewModel.networkManagerError) { _ in
                Button("OK"){
                    
                }
            } message: { networkError in
                Text(networkError.userMessage)
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

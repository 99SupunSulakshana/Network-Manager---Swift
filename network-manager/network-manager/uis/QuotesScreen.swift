//
//  QuotesScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct QuotesScreen: View {
    @State private var viewModel = DataViewModel<[Quote]>(url: TestURL.quotesURL)
    
    var body: some View {
        Group {
                if let quotes = viewModel.data, !quotes.isEmpty {
                    List(quotes.shuffled()) { quote in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(quote.text)
                                .font(.headline)
                            HStack {
                                Text(quote.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(quote.entryDate, format: .dateTime.month().day().year())
                                    .font(.caption)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        Task {
                            await viewModel.fetchData()
                        }
                        }
                } else {
                    ContentUnavailableView("No Quotes available", systemImage: "quote.closing")
                }
        }
        .withLoader(isLoading: viewModel.isLoading, title: "quates")
        .task {
            await viewModel.fetchData()
        }
        .alert(
            "Unable to load quates.",
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
        QuotesScreen()
            .navigationTitle(ViewOption.first.title)
            .toolbarTitleDisplayMode(.inlineLarge)
    }
}

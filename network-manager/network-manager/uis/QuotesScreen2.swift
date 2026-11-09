//
//  QuotesView2.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct QuotesPlus: Decodable {
    let lastUpdated: Date
    let quotes: [Quote]
}

struct QuotesScreen2: View {
    @State private var viewModel = DataViewModel<QuotesPlus>(endPoint: TestEndPoint.quotes2EndPoint)
    
    var body: some View {
        Group {
            if let quotePlus = viewModel.data {
                Text(quotePlus.lastUpdated, format: .dateTime.month().day().year())
                List(quotePlus.quotes.shuffled()) { quote in
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
                .refreshable {
                    Task {
                        await viewModel.fetchData()
                    }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No Quotes available", systemImage: "quote.closing")
            }
        }
        .withLoader(isLoading: viewModel.isLoading, title: "Quotes")
        .task {
            await viewModel.fetchData()
        }
        .alert(
            "Unable to load quates.",
            isPresented: Binding(get: {
                viewModel.networkManagerError != nil
            }, set: { value in
                if !value { viewModel.networkManagerError = nil }
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
        QuotesScreen2()
            .navigationTitle(ViewOption.third.title)
            .toolbarTitleDisplayMode(.inlineLarge)
    }
}

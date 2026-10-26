//
//  QuotesScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct QuotesScreen: View {
    @State private var quotes: [Quote]? = nil
    let manager = NetworkManager.shared
    
    var body: some View {
        Group {
            if let quotes {
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
            } else {
                ContentUnavailableView("No Quotes available", systemImage: "quote.closing")
            }
        }.task {
            quotes = await manager.fetchAndDecodeJSON(from: TestURL.quotesURL)
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

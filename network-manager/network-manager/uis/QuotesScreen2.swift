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
    @State private var quotePlus: QuotesPlus? = nil
    let manager = NetworkManager.shared
    var body: some View {
        Group {
            if let quotePlus {
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
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No Quotes available", systemImage: "quote.closing")
            }
        }
        .task {
            quotePlus = await manager.fetchAndDecodeJSON(from: TestURL.quotes2URL)
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

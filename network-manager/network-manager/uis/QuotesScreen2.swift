//
//  QuotesView2.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct QuotesScreen2: View {
    @State private var quotes: [Quote]? = nil
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

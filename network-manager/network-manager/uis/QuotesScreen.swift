//
//  QuotesScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct QuotesScreen: View {
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
        }.task {
            quotes = await fetchAndDecodeQuotes(from: TestURL.quotesURL)
        }
    }
    
    func fetchAndDecodeQuotes(from url:String) async -> [Quote]? {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Network error: Response was not HTTPURLResponse")
                return nil
            }
            guard (200...209).contains(httpResponse.statusCode) else {
                print("HTTP error: status code \(httpResponse.statusCode)")
                return nil
            }
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Quote].self, from: data)
            }catch {
                print("Decoding error: \(error.localizedDescription)")
                return nil
            }
        } catch{
            print("Request error: \(error.localizedDescription)")
            return nil
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

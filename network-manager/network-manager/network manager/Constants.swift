//
//  Constants.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-01.
//

enum TestURL {
    static let quotesURL = "https://stewartlynch.github.io/Samples/quotes.json"
    static let quotesURLRequestError = "https://invalid.stewartlynch.github.io/Samples/quotes.json"
    static let quotesURLResponseError = "data:text/plain,hello"
    static let quotesURLStatusError = "https://httpbin.org/status/500"
    static let quotesURLBadJSON = "https://stewartlynch.github.io/Samples/errorQuotes.json"
    
    static let jokesURL = "https://stewartlynch.github.io/Samples/jokes.json"
    
    static let quotes2URL = "https://stewartlynch.github.io/Samples/quotes2.json"
}

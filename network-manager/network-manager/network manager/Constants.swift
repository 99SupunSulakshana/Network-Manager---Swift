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
    static let gorestURL = "https://gorest.co.in/public/v3/users"
}


enum TestEndPoint {
    static var jokesEndPoint = Endpoint(urlString: TestURL.jokesURL, method: .get)
    static var userWithHeader = Endpoint(urlString: TestURL.gorestURL, method: .get)
    static var quotesEndPoint = Endpoint(urlString: TestURL.quotesURL, method: .get)
    static var quotes2EndPoint = Endpoint(urlString: TestURL.quotes2URL, method: .get)
}

let token = ""

//
//  ViewOption.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

enum ViewOption: CaseIterable, Identifiable, View {
    
    case first, second, third, fourth, fifth
    var id: Self { self }
    
    var title: String {
        switch self {
        case .first:
            "Quotes Array"
        case .second:
            "Jokes Array"
        case .third:
            "Quotes Dictionary"
        case .fourth:
            "Joke + EntryData"
        case .fifth:
            "Post"
        }
    }
    
    var picker: String {
        switch self {
        case .first:
            "Quotes Array"
        case .second:
            "Jokes Array"
        case .third:
            "Quotes Dictionary"
        case .fourth:
            "Joke + EntryData"
        case .fifth:
            "Post"
        }
    }
    
    @ViewBuilder
    var body: some View {
        switch self {
        case .first:
            QuotesScreen()
        case .second:
            JokesScreen()
        case .third:
            QuotesScreen2()
        case .fourth:
            JokesScreen2()
        case .fifth:
            PostView()
        }
    }
}


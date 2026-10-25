//
//  Joke.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import Foundation

struct Joke:Identifiable, Codable {
    let id: Int
    let setup: String
    let punchline: String
}

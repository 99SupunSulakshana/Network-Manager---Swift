//
//  Quote.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import Foundation

struct Quote: Decodable, Identifiable {
    let id: Int
    let text: String
    let author: String
    let entryDate: Date
}

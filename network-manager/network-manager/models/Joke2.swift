//
//  Jake2.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//
import Foundation

struct Joke2:Identifiable, Codable {
    let id: Int
    let setup: String
    let punchline: String
    let entryDate: Date
}

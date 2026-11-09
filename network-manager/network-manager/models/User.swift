//
//  User.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-02.
//

import SwiftUI
import Foundation

struct UserResponse: Codable {
    let data: [User]
    let meta: UserMeta
}

struct UserMeta: Codable {
    let hasMore: Bool
    let nextCursor: String?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case nextCursor = "next_cursor"
        case total
    }
}

struct User: Identifiable, Codable {
    enum Gender: String, Codable {
        case male
        case female
        
        var icon: String {
            switch self {
            case .male:
                "👦"
            case .female:
                "👧"
            }
        }
    }
    
    enum Status: String, Codable {
        case active, inactive
    }
    
    let id: String
    var name: String
    var email: String
    var gender: Gender?
    var status: Status
    var readOnly: Bool
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
            case id, name, email, gender, status
            case readOnly = "read_only"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
}

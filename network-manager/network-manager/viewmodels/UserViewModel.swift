//
//  UserViewModel.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-02.
//

import SwiftUI

@Observable
class UserViewModel {
    var users: [User] = []
    
    func fetchUsers() async throws {
        var endpoint = TestEndPoint.userWithHeader
        endpoint.addHeader("application/json", forHTTPHeaderField: "Content-Type")
        endpoint.addHeader("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let response: UserResponse = try await NetworkManager.shared.fetchAndDecodeJSON(from: endpoint)
        users = response.data
    }
}

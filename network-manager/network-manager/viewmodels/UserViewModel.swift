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
    
    func fetchUsers() async throws (NetworkManagerError) {
        var endpoint = TestEndPoint.userWithHeader
        endpoint.addHeader("application/json", forHTTPHeaderField: "Content-Type")
        endpoint.addHeader("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let response: UserResponse = try await NetworkManager.shared.fetchAndDecodeJSON(from: endpoint)
        users = response.data
    }
    
    func createUser(
        name:String,
        email: String,
        status: User.Status
    ) async throws(NetworkManagerError) {
        
        struct NewUserRequest: Encodable {
            let name: String
            let email:String
            let status: User.Status
        }

        let payload = NewUserRequest(
            name: name,
            email: email,
            status: status
        )
        
        var endpoint = TestEndPoint.createUser
        endpoint.addHeader("application/json", forHTTPHeaderField: "Content-Type")
        endpoint.addHeader("Bearer \(token)", forHTTPHeaderField: "Authorization")
        endpoint.addHeader("application/json", forHTTPHeaderField: "Accept")
        
        let _: User = try await NetworkManager.shared.sendJSONAndDecodeRespose(
            from: endpoint,
            payload: payload
        )
        
        try await fetchUsers()
                                                                                  
    }
    
    func updateUser(
        id: String,
        name:String,
        email: String,
        status: User.Status
    ) async throws(NetworkManagerError) {
    
        struct UpdateUserRequest: Encodable {
            let name: String
            let email:String
            let status: User.Status
        }

        let payload = UpdateUserRequest(
            name: name,
            email: email,
            status: status
        )
        
        var endpoint = TestEndPoint.updateUser(id: id)
        endpoint.addHeader("application/json", forHTTPHeaderField: "Content-Type")
        endpoint.addHeader("Bearer \(token)", forHTTPHeaderField: "Authorization")
        endpoint.addHeader("application/json", forHTTPHeaderField: "Accept")
        
        let _: User = try await NetworkManager.shared.sendJSONAndDecodeRespose(
            from: endpoint,
            payload: payload
        )
        
        try await fetchUsers()
                                                                                  
    }
    
    func deleteUsers(at offsets: IndexSet) async throws(NetworkManagerError) {
        let ids = offsets.map { users[$0].id }
        for id in ids {
            var endpoint = TestEndPoint.deleteUser(id: id)
            endpoint.addHeader("application/json", forHTTPHeaderField: "Content-Type")
            endpoint.addHeader("Bearer \(token)", forHTTPHeaderField: "Authorization")
            endpoint.addHeader("application/json", forHTTPHeaderField: "Accept")
            try await NetworkManager.shared.sendRequest(from: endpoint)
        }
        try await fetchUsers()
    }
}

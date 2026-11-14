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
        id: Int,
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
}

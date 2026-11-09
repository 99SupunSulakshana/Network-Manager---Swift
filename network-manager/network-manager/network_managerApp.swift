//
//  network_managerApp.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

@main
struct network_managerApp: App {
    @State private var usersModel = UserViewModel()
    var body: some Scene {
        WindowGroup {
            UsersScreen()
                .environment(usersModel)
        }
    }
}

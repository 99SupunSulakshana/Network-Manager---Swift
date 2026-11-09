//
//  UsersScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-09.
//

import SwiftUI

struct UsersScreen: View {
    @Environment(UserViewModel.self) var model
    
    var body: some View {
        List(model.users) { user in
            VStack(alignment: .leading){
                HStack{
                    Text(verbatim: user.gender?.icon ?? "👦")
                            .font(.largeTitle)
                    Text(user.name).font(.title.bold())
                }
                HStack {
                    Text(user.email)
                    Spacer()
                    Text(verbatim: String(user.id))
                                            .font(.caption.smallCaps())
                }
            }
            .strikethrough(user.status == .inactive)
        }
        .listStyle(.plain)
        .task {
            do {
                try await model.fetchUsers()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


#Preview {
    NavigationStack {
        UsersScreen()
            .navigationTitle(ViewOption.second.title)
            .toolbarTitleDisplayMode(.inlineLarge)
            .environment(UserViewModel())
    }
}

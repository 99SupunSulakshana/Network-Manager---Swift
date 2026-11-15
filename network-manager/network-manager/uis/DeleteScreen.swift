//
//  DeleteScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-15.
//

import SwiftUI

struct DeleteScreen: View {
    @Environment(UserViewModel.self) var model
    
    var body: some View {
        List {
            ForEach(model.users) { user in
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
            .onDelete { offsets in
                Task {
                    do {
                        try await model.deleteUsers(at: offsets)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .task {
            do {
                try await model.fetchUsers()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

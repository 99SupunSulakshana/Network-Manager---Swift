//
//  PutPatchView.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-14.
//

import SwiftUI

struct PutPatchView: View {
    @Environment(UserViewModel.self) var model
    @State private var selectedUser: User?
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
            .contentShape(Rectangle())
            .onTapGesture {
                selectedUser = user
            }
        }
        .listStyle(.plain)
        .sheet(item: $selectedUser){ user in
            CreateUserSheetView(user: user)
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

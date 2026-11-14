//
//  PostScreen.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-10.
//

import SwiftUI

struct PostView: View {
    @State private var isPresentingCreateSheet = false
    var body: some View {
        UsersScreen()
            .toolbar{
                ToolbarItem(
                    placement: .topBarTrailing,
                ){
                    Button{
                        isPresentingCreateSheet = !isPresentingCreateSheet
                    } label: {
                        Label("Create New User", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingCreateSheet){
                CreateUserSheetView()
            }
    }
}


#Preview {
    NavigationStack {
        PostView()
            .navigationTitle(ViewOption.third.title)
            .toolbarTitleDisplayMode(.inlineLarge)
            .environment(UserViewModel())
    }
}

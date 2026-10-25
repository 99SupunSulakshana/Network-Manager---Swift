//
//  StartView.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-24.
//

import SwiftUI

struct StartScreen: View {
    @State private var viewOption: ViewOption = .first
    var body: some View {
        NavigationStack {
            viewOption
                .navigationTitle(viewOption.title)
                .toolbarTitleDisplayMode(.inline)
        }
        .safeAreaInset(edge: .bottom) {
            Picker("View Option", selection: $viewOption) {
                ForEach(ViewOption.allCases) { viewCase in
                    Text(viewCase.picker)
                }
            }
            .background(.thinMaterial, in: Capsule())
            .shadow(color: .black.opacity(0.5), radius: 8, x: 5, y: 5)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
        }
    }
}

#Preview {
    StartScreen()
}

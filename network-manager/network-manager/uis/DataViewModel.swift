//
//  QuotesScreenViewModel.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-01.
//

import SwiftUI

@Observable
class DataViewModel<T: Decodable> {
    var data: T?
    private let manager = NetworkManager.shared
    var networkManagerError: NetworkManagerError? = nil
    var isLoading = false
    var url: String
    private let configurator: ((JSONDecoder)  -> Void)?
    
    init(url: String, configurator: ((JSONDecoder)  -> Void)? = nil){
        self.url = url
        self.configurator = configurator
    }
    
    func fetchData() async {
        isLoading = true
        networkManagerError = nil
        defer {
            isLoading = false
        }
        try? await Task.sleep(for: .seconds(1))
        do{
            if let configurator {
                data = try await manager.fetchAndDecodeJSON(from: url, configureDecoder: configurator)
            }else {
                data = try await manager.fetchAndDecodeJSON(from: url)
            }
        } catch let error {
            networkManagerError = error
        }
    }
}

struct Loader: ViewModifier {
    let isLoading : Bool
    let title: String
    func body(content: Content) -> some View {
        if isLoading {
            ProgressView("Loading \(title)...")
        }else {
            content
        }
    }
}

extension View {
    func withLoader(isLoading: Bool, title: String) -> some View {
        modifier(Loader(isLoading: isLoading, title: title))
    }
}

//
//  HTTPMethod.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-01.
//

import Foundation

enum HTTPMethod {
    case get, post, put, patch, delete
    
    var rawValue: String {
        String(describing: self).uppercased()
    }
}

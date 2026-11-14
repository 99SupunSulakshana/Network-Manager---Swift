//
//  NetworkManager.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-10-25.
//

import Foundation

enum NetworkManagerError: Error {
    case badURL
    case request(TransportError)
    case httpResponse
    case httpStatusCode(Int)
    case decoding
    
    var userMessage: String {
        switch self {
        case .request(let transportError):
            transportError.userMessage
        case .httpStatusCode(let code):
            switch code {
            case 401: "Session has expired."
            case 403: "You don't have permission to do that."
            case 404: "Not found."
            case 422: "Some of the details are invalid (for example, the email may already be in use)."
            case 429: "Too many requests. Please wait a moment and try again."
            case 500...599: "The server is having trouble, Please try again later."
            default: "Somethingh went wrong. Please try again."
            }
        default: "Somethingh went wrong. Please try again."
        }
    }
}

enum TransportError: Error {
    case offline, timedOut, dnsFailure, cannotConnect, cancelled, tlsFailture, unkown
    init(urlError: URLError){
        switch urlError.code {
        case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed:
            self = .offline
        case .timedOut:
            self = .timedOut
        case .dnsLookupFailed, .cannotFindHost:
            self = .cannotConnect
        case .cancelled:
            self = .cancelled
        case .secureConnectionFailed, .serverCertificateHasBadDate, .serverCertificateUntrusted, .serverCertificateHasUnknownRoot, .serverCertificateNotYetValid, .serverCertificateHasBadDate:
            self = .tlsFailture
        default:
            self = .unkown
        }
    }
    var userMessage: String {
        switch self {
        case .offline:
            "You appear to be offline. Check your internet connection and try again."
        case .timedOut:
            "The request time out. Try again."
        case .dnsFailure:
            "We cannot reach the server right now. Please try again later."
        case .cannotConnect:
            "We cannot reach the server right now. Please try again later."
        case .cancelled:
            "The request was cancelled."
        case .tlsFailture:
            "A secure connection could not be established."
        case .unkown:
            "A network error occurred. Please try again."
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchAndDecodeJSON<T: Decodable>(
        from url:String,
        configureDecoder: ((JSONDecoder) -> ())? = nil
    ) async throws(NetworkManagerError) -> T {
        
        guard let url = URL(string: url) else {
            print("Invalid URL")
            throw NetworkManagerError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Network error: Response was not HTTPURLResponse")
                throw NetworkManagerError.httpResponse
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP error: status code \(httpResponse.statusCode)")
                print("Response body: \(String(data: data, encoding: .utf8) ?? "<non-UTF8 body>")")
                throw NetworkManagerError.httpStatusCode(httpResponse.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                configureDecoder?(decoder)
                return try decoder.decode(T.self, from: data)
            } catch let error as DecodingError {
                print(decodingError(error: error))
                throw NetworkManagerError.decoding
            }
            catch {
                print("Decoding error: \(error.localizedDescription)")
                print("Data as string: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to String")")
                throw NetworkManagerError.decoding
            }
        } catch let networkError as NetworkManagerError {
            throw networkError
        }
        catch let urlError as URLError {
            throw NetworkManagerError.request(TransportError(urlError: urlError))
        }
        catch{
            print("Request error: \(error.localizedDescription)")
            throw NetworkManagerError.request(.unkown)
        }
    }
    
    func fetchAndDecodeJSON<T: Decodable>(
        from endPoint: Endpoint,
        configureDecoder: ((JSONDecoder) -> ())? = nil
    ) async throws(NetworkManagerError) -> T {
        let request = try endPoint.buildRequest()
        return try await executedAndDecodeJSON(from: request, configureDecoder: configureDecoder)
    }
    
    func sendJSONAndDecodeRespose<T: Decodable, Payload: Encodable>(
        from endPoint: Endpoint,
        payload: Payload,
        configureDecoder: ((JSONDecoder) -> ())? = nil
    ) async throws(NetworkManagerError) -> T {
        var request = try endPoint.buildRequest()
        guard let encodedPayload = try? JSONEncoder().encode(payload) else {
            fatalError("Unable to encode payload")
        }
        request.httpBody = encodedPayload
        return try await executedAndDecodeJSON(from: request, configureDecoder: configureDecoder)
    }
      
    func executedAndDecodeJSON<T: Decodable>(
        from request: URLRequest,
        configureDecoder: ((JSONDecoder) -> ())? = nil
    ) async throws(NetworkManagerError) -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Network error: Response was not HTTPURLResponse")
                throw NetworkManagerError.httpResponse
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP error: status code \(httpResponse.statusCode)")
                print("Response body: \(String(data: data, encoding: .utf8) ?? "<non-UTF8 body>")")
                throw NetworkManagerError.httpStatusCode(httpResponse.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                configureDecoder?(decoder)
                return try decoder.decode(T.self, from: data)
            } catch let error as DecodingError {
                print(decodingError(error: error))
                throw NetworkManagerError.decoding
            }
            catch {
                print("Decoding error: \(error.localizedDescription)")
                print("Data as string: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to String")")
                throw NetworkManagerError.decoding
            }
        } catch let networkError as NetworkManagerError {
            throw networkError
        }
        catch let urlError as URLError {
            throw NetworkManagerError.request(TransportError(urlError: urlError))
        }
        catch{
            print("Request error: \(error.localizedDescription)")
            throw NetworkManagerError.request(.unkown)
        }
    }
    
    func decodingError(error: DecodingError) -> String {
        switch error {
            
        case .typeMismatch(let type, let context):
            """
            Decoding Error: Type mismatch for type \(type)
            Context: \(context.debugDescription)
            Coding path: \(context.codingPath.map { $0.stringValue}.joined(separator: "->"))
            """
        case .valueNotFound(let type, let context):
            """
            Decoding Error: Value of type \(type) not found
            Context: \(context.debugDescription)
            Coding path: \(context.codingPath.map { $0.stringValue}.joined(separator: "->"))
            """
        case .keyNotFound(let codingKey, let context):
            """
            Decoding Error: Key '\(codingKey.stringValue)' not found
            Context: \(context.debugDescription)
            Coding path: \(context.codingPath.map { $0.stringValue}.joined(separator: "->"))
            """
        case .dataCorrupted(let context):
            """
            Decoding Error: Data corrupted
            Context: \(context.debugDescription)
            Coding path: \(context.codingPath.map { $0.stringValue}.joined(separator: "->"))
            """
        @unknown default:
            """
            Unkown Error: \(error.localizedDescription)
            """
        }
    }
    
    
}

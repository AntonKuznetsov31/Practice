//
//  NetworkService.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}

final public class NetworkService: NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

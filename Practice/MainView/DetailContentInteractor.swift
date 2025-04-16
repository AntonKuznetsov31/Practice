//
//  DetailContentViewInteractor.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import Foundation

protocol DetailContentInteraction {
    func getData() async throws -> DetailModel
}

final class DetailContentInteractor: DetailContentInteraction {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getData() async throws -> DetailModel {
        return try await withCheckedThrowingContinuation { continuation in
            networkService.getData() { result in
                switch result {
                case .success(let success):
                    continuation.resume(returning: success)
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                }
            }
        }
    }
}

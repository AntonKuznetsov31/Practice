//
//  DetailContentViewInteractor.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import Foundation

protocol DetailContentInteraction {
    func fetchDetail() async throws -> DetailContentViewModel.DataSource
}

final class DetailContentInteractor: DetailContentInteraction {
    
    private let networkService: NetworkServiceProtocol
    private let detailURL = URL(string: "https://run.mocky.io/v3/38a8e733-a0b8-46b9-adb6-a215d44d328b")!
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchDetail() async throws -> DetailContentViewModel.DataSource {
        try await networkService.fetch(from: detailURL)
    }
}

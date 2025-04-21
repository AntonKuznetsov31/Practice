//
//  DetailContentViewModel.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import Foundation

@MainActor
final public class DetailContentViewModel: ObservableObject {
    
    struct DataSource: Decodable {
        public let imageUrl: String
        public let titleText: String
        public let descriptionText: String
    }
    
    @Published var dataSource: DataSource = .init(imageUrl: "", titleText: "", descriptionText: "")
    @Published var error: String?
    
    private let interactor: DetailContentInteraction
    
    init(interactor: DetailContentInteraction = DetailContentInteractor(networkService: NetworkService())) {
        self.interactor = interactor
        Task {
            await fetchDetail()
        }
    }
    
    func fetchDetail() async {
        do {
            let result = try await interactor.fetchDetail()
            self.dataSource = result
        } catch {
            self.error = "Loading error: \(error.localizedDescription)"
        }
    }
}

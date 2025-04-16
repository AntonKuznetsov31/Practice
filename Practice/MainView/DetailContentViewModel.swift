//
//  DetailContentViewModel.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import Foundation

final public class DetailContentViewModel: ObservableObject {
    
    struct DataSource {
        let imageName: String
        let title: String
        let description: String?
        
        init(imageName: String, title: String, description: String?) {
            self.imageName = imageName
            self.title = title
            self.description = description
        }
    }
    
    @Published var model: DataSource = .init(imageName: "", title: "", description: "")
    
    let interactor: DetailContentInteraction

    init(interactor: DetailContentInteraction) {
        self.interactor = interactor
        loadData()
    }
    
    func reloadData() {
        loadData()
    }
}

private extension DetailContentViewModel {
    func loadData() {
        Task { @MainActor in
            async let data = try self.interactor.getData()
            do {
                let result = try await (data)
                self.model = .init(imageName: result.imageName, title: result.title, description: result.description)
            } catch {
                self.model = .init(imageName: "", title: "", description: "")
            }
        }
    }
}

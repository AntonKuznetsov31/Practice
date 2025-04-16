//
//  PracticeApp.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import SwiftUI

@main
struct PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            DetailContentView(viewModel: DetailContentViewModel(interactor: DetailContentInteractor(networkService: NetworkService())))
        }
    }
}

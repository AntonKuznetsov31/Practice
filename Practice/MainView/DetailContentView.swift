//
//  DetailContentView2.swift
//  Practice
//
//  Created by Anton Kuznetsov on 16/04/2025.
//

import SwiftUI

struct DetailContentView: View {
    
    @ObservedObject private var viewModel: DetailContentViewModel
    
    private let imageHeight: CGFloat = 300
    
    private var isLargeTitle: Bool { navigationTitle.isEmpty }
    
    @State private var isToolbarBackgroundHidden: Bool
    
    @State private var navigationTitle: String
    
    init(viewModel: DetailContentViewModel,
         navigationTitle: String = "",
         isToolbarBackgroundHidden: Bool = true) {
        self.viewModel = viewModel
        self.navigationTitle = navigationTitle
        self.isToolbarBackgroundHidden = isToolbarBackgroundHidden
    }
    
    var body: some View {
        ScrollView {
            contentView(for: viewModel.dataSource)
        }
        .ignoresSafeArea()
    }
    
    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        return offset > 0 ? imageHeight + offset : imageHeight
    }
    
    private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // (values will range from 0 - 1)
        return blur * 6 // Values will range from 0 - 6
    }
    
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        return offset > 0 ? -offset : 0
    }
    
    private var asyncImageProgressView: some View {
        VStack {
            ProgressView()
                .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func asyncImage(for url: String) -> some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: url), content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
                    .blur(radius: self.getBlurRadiusForImage(geometry))
                    .clipped()
                    .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
                    .accessibilityHidden(true)
            }, placeholder: {
                asyncImageProgressView
            })
        }
        .frame(height: imageHeight)
    }
    
    private func titles(for model: DetailContentViewModel.DataSource) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.dataSource.titleText)
                .font(.body)
                .foregroundStyle(Color.black)
            Text(viewModel.dataSource.descriptionText)
                .font(.body)
                .foregroundStyle(Color.gray)
        }
        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func contentView(for model: DetailContentViewModel.DataSource) -> some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                asyncImage(for: viewModel.dataSource.imageUrl)
                DonutChartView(currentSegmentIndex: 0)
                    .padding(.trailing, 12)
                    .padding(.bottom, -12)
            }
            titles(for: model)
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    DetailContentView(viewModel: DetailContentViewModel(interactor: DetailContentInteractor(networkService: NetworkService())))
}

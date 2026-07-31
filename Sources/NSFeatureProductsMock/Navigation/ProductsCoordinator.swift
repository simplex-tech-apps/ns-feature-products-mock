//
//  ProductsCoordinator.swift
//  NSFeatureProductsMock
//
//  Created by apple on 12/07/26.
//

import SwiftData
import SwiftUI
import NammaAppUI

// MARK: - Feature Routes
public enum ProductCoordinatorPage: Hashable {
    case productList
    case productDetail
    case productSearch
}

public enum ProductsCoordinatorSheet: String, Identifiable {
    public var id: String { rawValue }
    case filter
}

public enum ProductsCoordinatorCover: String, Identifiable {
    public var id: String { rawValue }
    case scanner
}

// MARK: - View Factory
@MainActor
public struct ProductViewFactory {
    public init() {}
    
    @ViewBuilder
    public func buildPage(_ page: ProductCoordinatorPage) -> some View {
        switch page {
        case .productList:
            let viewModel = ProductListViewModel()
            ProductListView(productListViewModel: viewModel)
            
        case .productDetail:
            let viewModel = ProductListViewModel()
            ProductDetailView(productDetailViewModel: viewModel)
            
        case .productSearch:
            let viewModel = ProductListViewModel()
            ProductSearchView(productSearchViewModel: viewModel)
        }
    }
    
    @ViewBuilder
    public func buildSheet(_ sheet: ProductsCoordinatorSheet) -> some View {
        switch sheet {
        case .filter:
            Text("Test")
        }
    }
    
    @ViewBuilder
    public func buildCover(_ cover: ProductsCoordinatorCover) -> some View {
        switch cover {
        case .scanner:
            Text("Test")
        }
    }
}

@MainActor
public struct ProductsCoordinator {
    private static let factory = ProductViewFactory()
    
    @ViewBuilder
    public static func buildPage(for route: ProductCoordinatorPage) -> some View {
        factory.buildPage(route)
    }
    
    @ViewBuilder
    public static func buildSheet(for sheet: ProductsCoordinatorSheet) -> some View {
        factory.buildSheet(sheet)
    }
    
    @ViewBuilder
    public static func buildCover(for cover: ProductsCoordinatorCover) -> some View {
        factory.buildCover(cover)
    }
}

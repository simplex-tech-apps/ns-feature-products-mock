//
//  ProductsCoordinator.swift
//  NSFeatureProductsMock
//
//  Created by apple on 12/07/26.
//

import SwiftData
import SwiftUI
import NammaAppUI

@MainActor
struct ProductsViewFactory {
    @ViewBuilder
    func buildPage(_ page: ProductsCoordinatorPage) -> some View {
        switch page {
        case .landingPage(let productsViewModel):
            ProductsView(productsViewModel: productsViewModel)
        }
    }
    
    @ViewBuilder
    func buildSheet(_ sheet: ProductsCoordinatorSheet) -> some View {
        EmptyView()
    }
    
    @ViewBuilder
    func buildCover(_ cover: ProductsCoordinatorCover) -> some View {
        EmptyView()
    }
}

enum ProductsCoordinatorPage: Hashable {
    case landingPage(ProductsViewModel)
}

enum ProductsCoordinatorSheet: String, Identifiable {
    var id: String { rawValue }
    case noSheet
}

enum ProductsCoordinatorCover: String, Identifiable {
    var id: String { rawValue }
    case noCover
}

extension EnvironmentValues {
    @Entry var ProductsCoordinator: ProductsCoordinator?
    @Entry var ProductsViewModel: ProductsViewModel?
}

@Observable
class ProductsCoordinator: NSObject {
    var path: NavigationPath = NavigationPath()
    var sheet: ProductsCoordinatorSheet?
    var cover: ProductsCoordinatorCover?
    private(set) var currenScreen: [ProductsCoordinatorPage] = []
    
    func push(page: ProductsCoordinatorPage) {
        currenScreen.append(page)
        path.append(page)
    }
    
    func pop(_ last: Int = 1) {
        currenScreen.removeLast()
        path.removeLast(last)
    }
    
    func popToRoot() {
        currenScreen.removeAll()
        path.removeLast(path.count)
    }
    
    func present(sheet: ProductsCoordinatorSheet) {
        self.sheet = sheet
    }
    
    func present(cover: ProductsCoordinatorCover) {
        self.cover = cover
    }
    
    func popSheet() {
        withAnimation(.spring()) {
            self.sheet = nil
        }
    }
    
    func popCover() {
        self.cover = nil
    }
}

public struct ProductsCoordinatorView: View {
    @State
    private var productsCoordinator = ProductsCoordinator()
    @State
    private var productsViewModel: ProductsViewModel = ProductsViewModel()
    @State
    private var appTheme = AppThemeManager.shared
    
    let productsViewFactory: ProductsViewFactory = ProductsViewFactory()
    
    public init() {}
    
    public var body: some View {
        productsViewFactory.buildPage(.landingPage(productsViewModel))
            .navigationDestination(for: ProductsCoordinatorPage.self) {
                productsViewFactory.buildPage($0)
            }
            .sheet(item: $productsCoordinator.sheet) { productsViewFactory.buildSheet($0).presentationBackground(appTheme.current.secondary).presentationDetents([.medium]).presentationCornerRadius(24)
            }
            .fullScreenCover(item: $productsCoordinator.cover) {
                productsViewFactory.buildCover($0)
            }
    }
}

//
//  ProductListView.swift
//  NSFeatureProducts
//
//  Created by apple on 07/07/26.
//

import SwiftUI
import SwiftData
import NammaAppUI

import SwiftUI

// MARK: - Models
struct SidebarCategory: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let iconName: String
    var isSelected: Bool = false
}

struct ProductItem: Identifiable {
    let id = UUID()
    let title: String
    let packInfo: String
    let currentPrice: Int
    let originalPrice: Int
    let discountBadge: String?
    let rating: Double
    let ratingCount: String
    let deliveryTime: String
    let tagText: String?
    let imageName: String
    var isFavorite: Bool = false
    var quantity: Int = 0
}

struct BrandItem: Identifiable {
    let id = UUID()
    let name: String
    let logoName: String
}

// MARK: - Main Screen View
public struct ProductListView: View {
    //MARK: Observed Properties
    var productListViewModel: ProductListViewModel
    
    let filters = ["Filters", "Sort", "Price", "Brand", "Colour", "Design", "Closure"]
    let categories = [
        NATabbarViewV3Model(
            id: "1",
            title: "All",
            imageName: "chicken_product"
        ),
        NATabbarViewV3Model(
            id: "2",
            title: "Greeting Cards",
            imageName: "chicken_product"
        ),
        NATabbarViewV3Model(
            id: "3",
            title: "Bracelets",
            imageName: "chicken_product"
        ),
        NATabbarViewV3Model(
            id: "4",
            title: "Coffee Mugs",
            imageName: "chicken_product"
        ),
        NATabbarViewV3Model(
            id: "5",
            title: "Bouquets",
            imageName: "chicken_product"
        ),
        NATabbarViewV3Model(
            id: "6",
            title: "Plants",
            imageName: "chicken_product"
        )
    ]
    
    @State private var products = [
        NAGridViewV2Model(
            title: "Blue Heaven Intense Matte Lipstick | Plum Desire 05",
            volumeInfo: "1 pc (4 g)",
            finishTag: "Matte Finish",
            currentPrice: 94,
            originalPrice: 110,
            discountText: "₹16 OFF",
            rating: 3.9,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 1,
            hasOptions: false,
            promotionText: "Buy 1 Get 1 Free"
        ),
        NAGridViewV2Model(
            title: "Lakme Forever Matte Liquid Lip, 16hr Lipstick, Light weight",
            volumeInfo: "5.6 ml",
            finishTag: "Matte Finish",
            currentPrice: 326,
            originalPrice: 450,
            discountText: "₹124 OFF",
            rating: 4.4,
            ratingCountText: "(1k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: false,
            promotionText: nil
        ),
        NAGridViewV2Model(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        NAGridViewV2Model(
            title: "Maybelline New York Superstay Matte Ink Liquid Lipstick",
            volumeInfo: "5 ml",
            finishTag: "Matte Finish",
            currentPrice: 499,
            originalPrice: 650,
            discountText: "₹151 OFF",
            rating: 4.5,
            ratingCountText: "(5k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: "Flat 20% OFF"
        )
    ]
    
    @State private var selectedFilter = "Filters"
    @State private var selectedCategory: NATabbarViewV3Model
    
    init(productListViewModel: ProductListViewModel) {
        self.productListViewModel = productListViewModel
        self._selectedCategory = State(initialValue: categories.first!)
    }
    
    let brands: [BrandItem] = [
        BrandItem(name: "Quace", logoName: "q.circle.fill"),
        BrandItem(name: "Tomuncle", logoName: "t.circle.fill"),
        BrandItem(name: "Party Propz", logoName: "p.circle.fill"),
        BrandItem(name: "FlowerAura", logoName: "f.circle.fill")
    ]

    public var body: some View {
        VStack(spacing: 0) {
        
            navigationHeaderView
        
            HStack(spacing: 0) {
                NATabbarViewV3(
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
                VStack(spacing: 0) {
                    filterBarView
                        .padding(.vertical, 8)
                        .background(Color.clear)
                    
                    NAGridViewV2(
                        items: $products,
                        orientation: .vertical,
                        gridCount: 2,
                        spacing: 10,
                        cardWidth: 140
                    )
                }
            }
        }
    }
}

// MARK: - Sidebar Cell View
struct SidebarCategoryCellView: View {
    let category: SidebarCategory
    let isSelected: Bool
    let namespace: Namespace.ID
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .trailing) {
                Rectangle()
                    .fill(isSelected ? Color.white : Color.clear)
                VStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .fill(isSelected ? Color.green.opacity(0.12) : Color.white)
                            .frame(width: 52, height: 52)
                        
                        Image(systemName: category.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(isSelected ? .green : .orange)
                    }
                    
                    Text(category.name)
                        .font(.system(size: 10, weight: isSelected ? .bold : .medium))
                        .foregroundColor(isSelected ? .black : .secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.trailing, 6)
                
                if isSelected {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.green)
                        .frame(width: 4, height: 42)
                        .matchedGeometryEffect(id: "sidebar_indicator", in: namespace)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Subviews Breakdown
private extension ProductListView {

    var navigationHeaderView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            }
            .padding(.horizontal, 12)
            
            Text("Bands, Cards & Flowers")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 12)
        }
        .padding(12)
        .background(Color.white)
    }
    
    var filterBarView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(filters, id: \.self) { filter in
                    Button(action: { selectedFilter = filter }) {
                        HStack(spacing: 4) {
                            if filter == "Filters" {
                                Image(systemName: "slider.horizontal.3")
                                    .font(.system(size: 11))
                            }
                            
                            Text(filter)
                                .font(.system(size: 11, weight: .medium))
                            
                            if filter != "Filters" {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 9))
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
        }
    }
    
    // Brand Carousel Section
    var shopByBrandsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Shop by brands")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(brands) { brand in
                        VStack(spacing: 6) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange.opacity(0.1))
                                    .frame(width: 65, height: 65)
                                
                                Image(systemName: brand.logoName)
                                    .font(.system(size: 28))
                                    .foregroundColor(.orange)
                            }
                            
                            Text(brand.name)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.black)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(.vertical, 10)
        .background(Color(red: 254/255, green: 252/255, blue: 243/255))
    }
}

// MARK: - Product Card Component
struct ProductGridCardView: View {
    @Binding var product: ProductItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topTrailing) {

                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                        .aspectRatio(1.0, contentMode: .fit)
                    
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundColor(.gray.opacity(0.4))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    Text(product.packInfo)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(6)
                }
                
                Button(action: { product.isFavorite.toggle() }) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(product.isFavorite ? .red : .gray)
                        .padding(6)
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                }
                .padding(6)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { product.quantity += 1 }) {
                            Text("ADD")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.green)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.green, lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.05), radius: 2)
                        }
                        .padding(6)
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("₹\(product.currentPrice)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.yellow.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                
                Text("₹\(product.originalPrice)")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .strikethrough()
            }
            .padding(.top, 4)

            if let badge = product.discountBadge {
                Text("Price Drop")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.blue)
                
                Text(badge)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.blue)
            }

            Text(product.title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.black.opacity(0.9))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            if let tag = product.tagText {
                Text(tag)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(.green)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(Color.green.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            }

            HStack(spacing: 4) {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 9))
                    .foregroundColor(.green)
                
                Text(product.ratingCount)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            HStack(spacing: 3) {
                Image(systemName: "timer")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                
                Text(product.deliveryTime)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Preview
#Preview {
    ProductListView(productListViewModel: ProductListViewModel())
}

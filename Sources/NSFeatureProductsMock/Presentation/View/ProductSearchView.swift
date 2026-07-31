//
//  ProductsSearchView.swift
//  NSFeatureProductsMock
//
//  Created by apple on 18/07/26.
//

import SwiftUI
import SwiftData
import NammaAppUI

// MARK: - Models
struct TrendingCategory: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
}

// MARK: - Main View
struct ProductSearchView: View {
    //MARK: Observed Properties
    var productSearchViewModel: ProductListViewModel
    @State private var searchText: String = ""
    
    let trendingItems: [TrendingCategory] = [
        TrendingCategory(name: "Kinder\nJoy Cho...", iconName: "gift.fill"),
        TrendingCategory(name: "Raincoat", iconName: "umbrella.fill"),
        TrendingCategory(
            name: "Tender\nCoconut...",
            iconName: "takeoutbag.and.cup.and.straw.fill"
        ),
        TrendingCategory(
            name: "Friendshi\np Band",
            iconName: "circle.grid.cross.fill"
        ),
        TrendingCategory(name: "Umb...", iconName: "cloud.rain.fill")
    ]
    
    let searchList: [NAStaggeredGridViewV2Model] = [
        NAStaggeredGridViewV2Model(text: "salt", imageName: nil),
        NAStaggeredGridViewV2Model(text: "mango", imageName: "leaf.fill"),
        NAStaggeredGridViewV2Model(text: "ch", imageName: nil),
        NAStaggeredGridViewV2Model(text: "cha", imageName: nil),
        NAStaggeredGridViewV2Model(text: "chi", imageName: nil),
        NAStaggeredGridViewV2Model(
            text: "sensodyne paste",
            imageName: "sparkles"
        ),
        NAStaggeredGridViewV2Model(
            text: "organic honey",
            imageName: "leaf.fill"
        ),
        NAStaggeredGridViewV2Model(text: "milk", imageName: nil)
    ]
    
    let sampleData1: [NAGridViewV1CardModel] = [
        NAGridViewV1CardModel(
            title: "Kuzhambu",
            imageName: "food",
            categoryBadge: "Gluten",
            badgeColor: Color(red: 254/255, green: 232/255, blue: 212/255),
            badgeTextColor: Color(red: 210/255, green: 110/255, blue: 40/255),
            prepTimeMinutes: 40
        ),
        NAGridViewV1CardModel(
            title: "Ridge Gourd Kootu Anand",
            imageName: "food",
            categoryBadge: "Main Course",
            badgeColor: Color(red: 228/255, green: 244/255, blue: 244/255),
            badgeTextColor: Color(red: 16/255, green: 120/255, blue: 130/255),
            prepTimeMinutes: 30
        ),
        NAGridViewV1CardModel(
            title: "Lemon Rice",
            imageName: "food",
            categoryBadge: "Main Course",
            badgeColor: Color(red: 228/255, green: 244/255, blue: 244/255),
            badgeTextColor: Color(red: 16/255, green: 120/255, blue: 130/255),
            prepTimeMinutes: 15
        ),
        NAGridViewV1CardModel(
            title: "Egg Biryani",
            imageName: "food",
            categoryBadge: "Main Course",
            badgeColor: Color(red: 228/255, green: 244/255, blue: 244/255),
            badgeTextColor: Color(red: 16/255, green: 120/255, blue: 130/255),
            prepTimeMinutes: 60
        ),
        NAGridViewV1CardModel(
            title: "Masala Uttapam",
            imageName: "food",
            categoryBadge: "Vegan",
            badgeColor: Color(red: 220/255, green: 245/255, blue: 220/255),
            badgeTextColor: Color(red: 30/255, green: 140/255, blue: 40/255),
            prepTimeMinutes: 30
        ),
        NAGridViewV1CardModel(
            title: "Beans Kootu",
            imageName: "food",
            categoryBadge: "Tamil",
            badgeColor: Color(red: 254/255, green: 232/255, blue: 212/255),
            badgeTextColor: Color(red: 210/255, green: 110/255, blue: 40/255),
            prepTimeMinutes: 30
        )
    ]
    
    @State private var sampleData2 = [
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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                NASearchBar(
                    searchText: .constant(""),
                    onBackTap: { print("Back tapped") },
                    onMicTap: { print("Mic tapped") }
                )
                .padding(.horizontal, 16)
                
                ReusableHeaderView(style: .action(title: "Recent Searches", actionTitle: "clear", onAction: {
                    
                }))
                
                NAStaggeredGridViewV2(
                    items: searchList,
                    orientation: .vertical,
                    spacing: 10
                )
                
                trendingSection
                
                ReusableHeaderView(
                    style: .standard(title: "Ice Cream & Frozen Dessert")
                )
                
                NAGridViewV2(
                    items: $sampleData2,
                    orientation: .vertical,
                    gridCount: 3,
                    spacing: 12,
                    cardWidth: 140
                )
                
                ReusableHeaderView(style: .standard(title: "Cooking ideas"))
                
                NAGridViewV1(
                    items: sampleData1,
                    orientation: .vertical,
                    gridCount: 3,
                    spacing: 12
                )
            }
            .padding(.top, 8)
        }
        .background(Color(uiColor: .systemGroupedBackground).opacity(0.3))
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Subviews
private extension ProductSearchView {
    var trendingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Trending in your city")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.primary)
                .padding(.horizontal, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(trendingItems) { item in
                        VStack(spacing: 8) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .frame(width: 76, height: 76)
                                
                                Image(systemName: item.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.orange)
                            }
                            
                            Text(item.name)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(width: 76)
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .padding(.vertical, 12)
        .background(Color(red: 254/255, green: 252/255, blue: 243/255))
    }
}

// MARK: - Preview
#Preview {
    @MainActor struct PreviewWrapper: View {
        var body: some View {
            ProductSearchView(productSearchViewModel: ProductListViewModel())
        }
    }
    return PreviewWrapper()
}

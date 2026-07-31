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
    // MARK: Observed Properties
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
    
    @State private var searchList: [NAStaggeredGridViewV2Model] = [
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
        )
    ]
    
    let sampleSuggestions: [SearchSuggestionItem] = [
        SearchSuggestionItem(title: "Hajmola tablet", imageName: "pill.fill", isSystemImage: true),
        SearchSuggestionItem(title: "Table", imageName: "table.furniture.fill", isSystemImage: true),
        SearchSuggestionItem(title: "Table fan", imageName: "fan.oscillation.fill", isSystemImage: true),
        SearchSuggestionItem(title: "Study table", imageName: "book.closed.fill", isSystemImage: true),
        SearchSuggestionItem(title: "Paracetamol tablet", imageName: "pills.fill", isSystemImage: true),
        SearchSuggestionItem(title: "Dolo tablet", imageName: "pills.circle.fill", isSystemImage: true),
        SearchSuggestionItem(title: "Tablet", imageName: "ipad", isSystemImage: true),
        SearchSuggestionItem(title: "Tabs", imageName: "square.stack.fill", isSystemImage: true)
    ]
    
    private var filteredSearchResults: Binding<[NAGridViewV2Model]> {
        Binding(
            get: {
                if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return sampleData2
                } else {
                    return sampleData2.filter {
                        $0.title.localizedCaseInsensitiveContains(searchText) ||
                        $0.finishTag.localizedCaseInsensitiveContains(searchText)
                    }
                }
            },
            set: { updatedItems in
                for updatedItem in updatedItems {
                    if let index = sampleData2.firstIndex(where: { $0.id == updatedItem.id }) {
                        sampleData2[index] = updatedItem
                    }
                }
            }
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            NASearchBar(
                searchText: $searchText,
                onBackTap: {
                    searchText = ""
                },
                onMicTap: {
             
                }
            )
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                defaultDiscoveryView
                    .transition(.opacity.combined(with: .move(edge: .top)))
            } else {
                activeSearchResultsView
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .animation(.smooth(duration: 0.25), value: searchText.isEmpty)
        .background(Color(uiColor: .systemGroupedBackground).opacity(0.25))
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Subviews & Views Modes
private extension ProductSearchView {
    var defaultDiscoveryView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ReusableHeaderView(
                    style: .action(
                        title: "Recent Searches",
                        actionTitle: "clear",
                        onAction: {
                            searchList.removeAll()
                        }
                    )
                )
                
                if !searchList.isEmpty {
                    NAStaggeredGridViewV2(
                        items: searchList,
                        orientation: .vertical,
                        spacing: 10
                    )
                }
                
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
    }
    
    var activeSearchResultsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if filteredSearchResults.wrappedValue.isEmpty {
                emptyResultsStateView
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    SearchSuggestionsListView(
                        items: sampleSuggestions,
                        searchQuery: searchText
                    )
                    HStack {
                        Text("Search Results for")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                        
                        Text("\"\(searchText)\"")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(filteredSearchResults.wrappedValue.count) items")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 12)
                    NAGridViewV2(
                        items: filteredSearchResults,
                        orientation: .vertical,
                        gridCount: 3,
                        spacing: 12,
                        cardWidth: 140
                    )
                }
            }
        }
    }

    var emptyResultsStateView: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 40)
            
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 48))
                .foregroundColor(.gray.opacity(0.6))
            
            Text("No results found for \"\(searchText)\"")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
            
            Text("Check the spelling or try searching with different keywords")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Spacer(minLength: 40)
        }
        .frame(maxWidth: .infinity)
    }
    
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


// MARK: - Search Suggestion Model
public struct SearchSuggestionItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let imageName: String
    public let isSystemImage: Bool
    
    public init(title: String, imageName: String, isSystemImage: Bool = false) {
        self.title = title
        self.imageName = imageName
        self.isSystemImage = isSystemImage
    }
}

// MARK: - Search Suggestion Row View
public struct SearchSuggestionRowView: View {
    public let item: SearchSuggestionItem
    public let searchQuery: String
    
    public var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: 24, height: 24)
                
                if item.isSystemImage {
                    Image(systemName: item.imageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 12, height: 12)
                } else {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            
            highlightedText(for: item.title, query: searchQuery)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
            
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .background(Color(red: 0.98, green: 0.97, blue: 0.94))
    }
    
    // MARK: - Attributed Text Highlighting Helper
    private func highlightedText(for text: String, query: String) -> Text {
        guard !query.isEmpty, let range = text.range(of: query, options: .caseInsensitive) else {
            return Text(text)
        }
        
        let prefix = String(text[..<range.lowerBound])
        let match = String(text[range])
        let suffix = String(text[range.upperBound...])
        
        return Text(prefix)
            .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
            + Text(match)
            .foregroundColor(Color(red: 0.45, green: 0.50, blue: 0.60))
            + Text(suffix)
            .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
    }
}

// MARK: - Search Suggestions List View
public struct SearchSuggestionsListView: View {
    public let items: [SearchSuggestionItem]
    public let searchQuery: String
    public var onItemTap: ((SearchSuggestionItem) -> Void)?
    
    public init(
        items: [SearchSuggestionItem],
        searchQuery: String,
        onItemTap: ((SearchSuggestionItem) -> Void)? = nil
    ) {
        self.items = items
        self.searchQuery = searchQuery
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 4) {
                ForEach(items) { item in
                    Button(action: { onItemTap?(item) }) {
                        SearchSuggestionRowView(item: item, searchQuery: searchQuery)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 8)
        }
        .background(Color(red: 0.98, green: 0.97, blue: 0.94).ignoresSafeArea())
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

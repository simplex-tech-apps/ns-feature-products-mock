//
//  ProductsDetailView.swift
//  NSFeatureProductsMock
//
//  Created by apple on 18/07/26.
//
//
//  ProductsDetailView.swift
//  NSFeatureProductsMock
//
//  Created by apple on 18/07/26.
//

import SwiftUI
import SwiftData
import NammaAppUI

// MARK: - Product Detail Model
public struct ProductDetailModel {
    public let title: String
    public let quantityText: String
    public let currentPrice: Int
    public let originalPrice: Int
    public let discountText: String
    public let deliveryTime: String
    public let imageNames: [String]
}

// MARK: - Product Detail View
public struct ProductDetailView: View {
    // MARK: Observed Properties
    var productDetailViewModel: ProductListViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var topSafeArea: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    
    @State private var isHighlightsExpanded: Bool = true
    @State private var isInformationExpanded: Bool = true
    
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
    
    let product = ProductDetailModel(
        title: "Onion (Vengayam)",
        quantityText: "Net quantity: 900 g - 1 kg",
        currentPrice: 37,
        originalPrice: 100,
        discountText: "₹63 OFF",
        deliveryTime: "11 mins",
        imageNames: ["onion", "onion", "onion"]
    )
    
    private let headerStartThreshold: CGFloat = 100
    private let headerTransitionDistance: CGFloat = 80
    private let baseCarouselHeight: CGFloat = 340

    public var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    GeometryReader { geo in
                        let minY = geo.frame(in: .named("productDetailScroll")).minY
                        Color.clear.onChange(of: minY) { _, newValue in
                            self.scrollOffset = -newValue
                        }
                    }
                    .frame(height: 0)

                    parallaxHeaderCarousel
                    
                    VStack(spacing: 12) {
                        productHeaderCard
                            .padding(.horizontal, 12)
                        
                        featureBadgesSection
                            .padding(.horizontal, 12)
                        
                        highlightsAccordionCard
                            .padding(.horizontal, 12)
                        
                        informationAccordionCard
                            .padding(.horizontal, 12)
                        
                        similarProducts
                            .padding(.horizontal, 12)
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.top, 12)
                }
            }
            .coordinateSpace(name: "productDetailScroll")
            .contentMargins(.top, 0, for: .scrollContent)
            .ignoresSafeArea(edges: .top)
            .scrollBounceBehavior(.basedOnSize)
            .background(Color(uiColor: .systemGroupedBackground).opacity(0.4))
            
            animatedNavigationBar

            bottomStickyCTA
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: [.top, .bottom])
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let topInset = windowScene.windows.first?.safeAreaInsets.top {
                self.topSafeArea = topInset
            }
        }
    }
}

// MARK: - Subviews Breakdown
private extension ProductDetailView {

    var parallaxHeaderCarousel: some View {
        let pullDistance = max(0, -scrollOffset)
        let totalHeight = baseCarouselHeight + topSafeArea + pullDistance
        
        return ZStack(alignment: .top) {
            imageCarouselSection
                .frame(height: totalHeight)
                .offset(y: -pullDistance)
        }
        .frame(height: baseCarouselHeight + topSafeArea)
        .zIndex(1)
    }
    
    var headerProgress: CGFloat {
        let rawProgress = (scrollOffset - headerStartThreshold) / headerTransitionDistance
        return min(max(rawProgress, 0.0), 1.0)
    }
    
    var animatedNavigationBar: some View {
        let progress = headerProgress
        
        return VStack(spacing: 0) {
            HStack(spacing: 12) {
                
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.9 * (1 - progress)))
                        )
                }
                
                HStack(spacing: 8) {
                    Image("onion", bundle: .module)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(6)
                        .frame(width: 34, height: 34)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(product.title)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        
                        HStack(spacing: 4) {
                            Text("₹\(product.currentPrice)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("₹\(product.originalPrice)")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                                .strikethrough()
                        }
                    }
                }
                .opacity(progress)
                .offset(y: (1 - progress) * 6)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.9 * (1 - progress)))
                        )
                }
                
                Button(action: {}) {
                    Image(systemName: "heart")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.9 * (1 - progress)))
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, topSafeArea > 0 ? topSafeArea : 44)
            .padding(.bottom, 10)
            .background(
                Color.white
                    .opacity(progress)
                    .shadow(
                        color: Color.black.opacity(progress * 0.08),
                        radius: 4,
                        x: 0,
                        y: 3
                    )
            )
        }
    }

    var imageCarouselSection: some View {
        TabView {
            ForEach(product.imageNames.indices, id: \.self) { _ in
                ZStack {
                    Color(red: 248/255, green: 242/255, blue: 236/255)
                    
                    Image("onion", bundle: .module)
                        .resizable()
                        .scaledToFill()
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    
    var similarProducts: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReusableHeaderView(
                style: .standard(title: "Similar Products")
            )
            
            NAGridViewV2(
                items: $sampleData2,
                orientation: .vertical,
                gridCount: 3,
                spacing: 12,
                cardWidth: 140
            )
        }
        .padding(.bottom, 12)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var productHeaderCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                
                Text(product.deliveryTime)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.black)
            }

            Text(product.title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
            
            Text(product.quantityText)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
            
            HStack(alignment: .center, spacing: 6) {
                Text("₹\(product.currentPrice)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(
                        Color(red: 20/255, green: 120/255, blue: 50/255)
                    )
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(
                        Color(red: 200/255, green: 240/255, blue: 205/255)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                HStack(spacing: 2) {
                    Text("MRP")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    
                    Text("₹\(product.originalPrice)")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .strikethrough()
                    
                    Text("(incl. of all taxes)")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                
                Text(product.discountText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(
                        Color(red: 20/255, green: 120/255, blue: 50/255)
                    )
            }
            .padding(.top, 4)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var featureBadgesSection: some View {
        HStack(spacing: 10) {
            featureBadgeTile(
                icon: "arrow.triangle.2.circlepath",
                title: "No Return or Exchange"
            )
            featureBadgeTile(
                icon: "bolt.shield.fill",
                title: "Fast Delivery"
            )
        }
    }
    
    func featureBadgeTile(icon: String, title: String) -> some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
            }
            
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var highlightsAccordionCard: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isHighlightsExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Highlights")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(
                        systemName: isHighlightsExpanded ? "chevron.up" : "chevron.down"
                    )
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                }
                .padding(14)
            }
            
            if isHighlightsExpanded {
                VStack(spacing: 10) {
                    detailRow(label: "Product Type", value: "Vegetable")
                    detailRow(label: "Imported", value: "No")
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var informationAccordionCard: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isInformationExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Information")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(
                        systemName: isInformationExpanded ? "chevron.up" : "chevron.down"
                    )
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                }
                .padding(14)
            }
            
            if isInformationExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        Text("Disclaimer")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.secondary)
                            .frame(width: 90, alignment: .leading)
                        
                        Text(
                            "The onion (Allium cepa) is a fundamental subterranean bulb vegetable belonging to the Amaryllidaceae family and the genus Allium..."
                        )
                        .font(.system(size: 11))
                        .foregroundColor(.black.opacity(0.8))
                    }
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.system(size: 12))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
    
    var bottomStickyCTA: some View {
        VStack(spacing: 0) {
            Button(action: {}) {
                Text("Add to Cart")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        Color(red: 235/255, green: 45/255, blue: 85/255)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
        .safeAreaPadding(.bottom)
        .background(
            Color.white
                .shadow(
                    color: Color.black.opacity(0.06),
                    radius: 6,
                    x: 0,
                    y: -3
                )
        )
    }
}

// MARK: - Preference Key for Scroll Tracking
private struct ScrollOffsetPreferenceKey: PreferenceKey {
    nonisolated(unsafe) static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Preview
#Preview {
    ProductDetailView(productDetailViewModel: ProductListViewModel())
}

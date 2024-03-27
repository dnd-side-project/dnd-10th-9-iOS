//
//  CollectionView.swift
//  DOTCHI
//
//  Created by yubin on 2/13/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(.icnBack)
        }
    }
}

struct CollectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedButton: String = "LATEST"
    
    @ObservedObject var themeViewModel = ThemeViewModel()
    
    var themeId: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dotchiBlack5.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        if let luckyTypeName = LuckyType(rawValue: themeId)?.name() {
                            Text("\(luckyTypeName)" + "을 빌어주는 따봉도치")
                                .font(.Title)
                                .foregroundStyle(Color.dotchiWhite)
                        }
                            
                        HStack {
                            Button(action: {
                                selectedButton = "LATEST"
                                themeViewModel.fetchTheme(themeId: themeId, cardSortType: selectedButton, lastCardId: APIConstants.pagingDefaultValue, lastCardCommentCount: APIConstants.pagingDefaultValue)
                            }) {
                                Text("최신순")
                                    .font(.Head2)
                                    .foregroundColor(selectedButton == "LATEST" ? Color.dotchiGreen : Color.dotchiWhite)
                                    .opacity(selectedButton == "LATEST" ? 1.0 : 0.5)
                            }
                            
                            Button(action: {
                                selectedButton = "HOT"
                                themeViewModel.fetchTheme(themeId: themeId, cardSortType: selectedButton, lastCardId: APIConstants.pagingDefaultValue, lastCardCommentCount: APIConstants.pagingDefaultValue)
                            }) {
                                Text("인기순")
                                    .font(.Head2)
                                    .foregroundColor(selectedButton == "HOT" ? Color.dotchiGreen : Color.dotchiWhite)
                                    .opacity(selectedButton == "HOT" ? 1.0 : 0.5)
                            }
                        }
                        
                        if let cards = themeViewModel.themeResult?.result.cards {
                            CardGridView(cards: cards)
                        } else {
                            Text("Loading...")
                                .font(.Title)
                                .foregroundStyle(Color.dotchiWhite)
                        }
                    }
                    .padding(.top, 16)
                }
                .padding(.vertical, 26)
                .padding(.horizontal, 28)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .navigationBarColor(backgroundColor: .dotchiBlack)
        }
        .onAppear() {
            themeViewModel.fetchTheme(themeId: themeId, cardSortType: selectedButton, lastCardId: APIConstants.pagingDefaultValue, lastCardCommentCount: APIConstants.pagingDefaultValue)
        }
    }
}

struct CardGridView: View {
    let cards: [Card]

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
        ], spacing: 12) {
            ForEach(cards) { card in
                CardView(card: card)
            }
        }
    }
}

struct CardView: View {
    let card: Card
    @State private var isDetailPresented = false
    @State private var selectedCardId: Int?
    
    var body: some View {
        Button(action: {
            selectedCardId = card.cardId
            isDetailPresented = true
        }) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    GeometryReader { geometry in
                        AsyncImageView(url: URL(string: card.cardImageUrl ?? ""))
                            .scaledToFill()
                            .frame(width: geometry.size.width * (210.0 / 270.0),
                                   height: geometry.size.width * (210.0 / 270.0))
                            .clipped()
                            .position(x: geometry.size.width * 0.5,
                                      y: geometry.size.height * 0.46)
                    }
                    
                    Image(getFrontImageName(forThemeId: card.themeId))
                        .resizable()
                        .frame(width: 163, height: 241)
                }
                
                Text(card.backName)
                    .font(.Dotchi_Name2)
                    .foregroundStyle(card.themeType.colorFont())
                    .padding(.bottom, 20)
            }
        }
        .fullScreenCover(isPresented: Binding(
            get: { isDetailPresented },
            set: { isDetailPresented = $0; selectedCardId = nil }
        )) {
            DotchiDetailViewControllerRepresentable(cardId: selectedCardId ?? 0)
                .transition(.move(edge: .trailing))
                .ignoresSafeArea()
        }
    }
}

func getLuckyType(forThemeId themeId: Int) -> LuckyType {
    return LuckyType(rawValue: themeId) ?? .lucky
}

func getFrontImageName(forThemeId themeId: Int) -> String {
    let luckyType = getLuckyType(forThemeId: themeId)
    return luckyType.imageNameFront()
}

#Preview {
    CollectionView(themeId: 1)
}

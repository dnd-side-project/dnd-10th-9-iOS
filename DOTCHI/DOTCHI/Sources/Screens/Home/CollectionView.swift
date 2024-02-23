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
                Color.dotchiBlack.ignoresSafeArea()
                
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

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                AsyncImageView(url: URL(string: card.cardImageUrl ?? ""))
                    .scaledToFill()
                    .frame(width: 163, height: 241)
                    .cornerRadius(9.64)
                
                Image(getFrontImageName(forThemeId: card.themeId))
                    .resizable()
                    .frame(width: 163, height: 241)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 60.25)
                        .fill(card.themeType.colorFont())
                        .frame(width: 60, height: 20)
                    
                    HStack(spacing: 0) {
                        AsyncImageView(url: URL(string: card.memberImageUrl ?? ""))
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                            .clipShape(Circle())
                        
                        Text(card.memberName)
                            .font(.S_Sub)
                            .foregroundStyle(Color.dotchiWhite)
                            .padding(.leading, 4)
                    }
                }
                .padding(.top, 16)
            }
            
            Text(card.backName)
                .font(.Dotchi_Name2)
                .foregroundStyle(card.themeType.colorFont())
                .padding(.bottom, 20)
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

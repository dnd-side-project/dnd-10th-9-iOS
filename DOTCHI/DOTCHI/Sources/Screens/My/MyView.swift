//
//  MyView.swift
//  DOTCHI
//
//  Created by yubin on 2/6/24.
//

import SwiftUI

struct MyView: View {
    @State private var isProfileEditViewPresented = false
    @ObservedObject var myViewModel = MyViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dotchiBlack.ignoresSafeArea()
                
                VStack {
                    AsyncImage(url: URL(string: myViewModel.myResult?.result.member.memberImageUrl ?? "")) { phase in
                        switch phase {
                        case .empty:
                            Image(.imgDefaultDummy)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 116, height: 116)
                                .cornerRadius(24)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 116, height: 116)
                                .cornerRadius(24)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        case .failure:
                            Image(.imgDefaultDummy)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 116, height: 116)
                                .cornerRadius(24)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        @unknown default:
                            Image(.imgDefaultDummy)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 116, height: 116)
                                .cornerRadius(24)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                    
                    Text(myViewModel.myResult?.result.member.memberName ?? "")
                        .font(.Body)
                        .foregroundColor(Color.dotchiWhite)
                        .padding(.top, 15)
                    
                    let description = myViewModel.myResult?.result.member.description ?? ""
                    if description.count > 20 {
                        let firstLineIndex = description.index(description.startIndex, offsetBy: 20)
                        let firstLine = String(description.prefix(upTo: firstLineIndex))
                        let secondLine = String(description.suffix(from: firstLineIndex))
                        
                        Text(firstLine + "\n" + secondLine)
                            .font(.Sub_Sbold)
                            .foregroundColor(Color.dotchiLgray)
                            .padding(.top, 4)
                            .padding(.bottom, 22)
                            .multilineTextAlignment(.center)
                    } else {
                        Text(description)
                            .font(.Sub_Sbold)
                            .foregroundColor(Color.dotchiLgray)
                            .padding(.top, 4)
                            .padding(.bottom, 38)
                    }
                    
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("공유 따봉도치")
                                .font(.Head2)
                                .foregroundStyle(Color.dotchiWhite)
                            
                            Text(String(myViewModel.myResult?.result.recentCards.count ?? 0) ?? "")
                                .font(.Head2)
                                .foregroundStyle(Color.dotchiGreen)
                        }
                        
                        if let cards = myViewModel.myResult?.result.recentCards, !cards.isEmpty {
                            MyCardGridView(cards: cards)
                                .padding(.top, 15)
                                .padding(.bottom, 30)
                        } else {
                            ZeroView()
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.dotchiMgray)
                                        .frame(maxWidth: .infinity)
                                )
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.dotchiMgray)
                    )
                    .fullScreenCover(isPresented: $isProfileEditViewPresented, content: {
                        SettingView()
                            .transition(.move(edge: .trailing))
                    })
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                    isProfileEditViewPresented.toggle()
                }) {
                    Image(.icnSetting)
                }
                )
                .navigationBarColor(backgroundColor: .dotchiBlack)
            }
        }
        .onAppear() {
            myViewModel.fetchMy(memberId: UserInfo.shared.userID, lastCardId: APIConstants.pagingDefaultValue)
        }
    }
}

struct ZeroView: View {
    var body: some View {
        VStack {
            Image(.imgNClover)
                .frame(width: 155.9, height: 132)
                .padding(.top, 90)
            
            Text("아직 베푼 행운이 없어요!")
                .font(.Head2)
                .foregroundStyle(Color.dotchiGray2)
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.dotchiMgray)
        )
    }
}

struct MyCardGridView: View {
    let cards: [RecentCardDTO]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
        ], spacing: 12) {
            ForEach(cards) { card in
                MyCardView(card: card)
            }
        }
    }
}

struct MyCardView: View {
    let card: RecentCardDTO
    
    @State private var isDetailPresented = false
    @State private var selectedCardId: Int?
    
    @ObservedObject var myViewModel = MyViewModel()
    
    var body: some View {
        Button(action: {
            selectedCardId = card.cardId
            isDetailPresented = true
        }) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .center) {
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

#Preview {
    MyView()
}

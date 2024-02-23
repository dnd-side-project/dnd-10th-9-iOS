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
                    AsyncImageView(url: URL(string: myViewModel.myResult?.result.member.memberImageUrl ?? ""))
                        .frame(width: 116, height: 116)
                        .cornerRadius(24)
                        .scaledToFill()
                    
                    Text(myViewModel.myResult?.result.member.memberName ?? "")
                        .font(.Body)
                        .foregroundColor(Color.dotchiWhite)
                        .padding(.top, 15)
                    
                    Text(myViewModel.myResult?.result.member.description ?? "")
                        .font(.Sub_Sbold)
                        .foregroundColor(Color.dotchiLgray)
                        .padding(.top, 10)
                        .padding(.bottom, 31)
                    
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("나의 따봉도치")
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
                        ProfileEditView()
                            .transition(.move(edge: .trailing))
                    })
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                    isProfileEditViewPresented.toggle()
                }) {
                    Image(.icnEdit)
                }
                )
                .navigationBarColor(backgroundColor: .dotchiBlack)
            }
        }
        .onAppear() {
            myViewModel.fetchMy(memberId: UserInfo.shared.userID, lastCardId: 999999)
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
    
    @ObservedObject var myViewModel = MyViewModel()
    
    var body: some View {
        NavigationLink(
            destination: DotchiDetailViewControllerWrapper(cardId: card.cardId)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea()
        ) {
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
                            AsyncImageView(url: URL(string: myViewModel.myResult?.result.member.memberImageUrl ?? ""))
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
}

#Preview {
    MyView()
}

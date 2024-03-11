//
//  HomeView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import SwiftUI

struct DotchiDetailViewControllerWrapper: UIViewControllerRepresentable {
    let cardId: Int
    
    func makeUIViewController(context: Context) -> DotchiDetailViewController {
        return DotchiDetailViewController(cardId: cardId)
    }
    
    func updateUIViewController(_ uiViewController: DotchiDetailViewController, context: Context) {
    }
}

struct HomeView: View {
    let currentDate = Date()
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: currentDate)
    }
    
    @ObservedObject var homeViewModel = HomeViewModel()
    @State private var isDetailPresented = false
    @State private var selectedCardId: Int?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dotchiBlack.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ZStack {
                            LottieView(filename: "pung", numberOfPlays: 3)
                                .frame(height: 170)
                            
                            VStack {
                                if let todayCards = homeViewModel.homeResult?.result.todayCards, todayCards.count != 0 {
                                    Text("가장 많은 행운을\n나눠준 오늘의 따봉도치")
                                        .font(.Head)
                                        .foregroundStyle(.dotchiWhite)
                                        .multilineTextAlignment(.center)
                                } else {
                                    Text("아직 오늘의\n따봉도치가 없어요 🥹")
                                        .font(.Head)
                                        .foregroundStyle(.dotchiWhite)
                                        .multilineTextAlignment(.center)
                                }
                                
                                HStack {
                                    Image(.icnGraph)
                                        .frame(width: 11, height: 13)
                                    
                                    Text("\(formattedDate) 기준")
                                        .font(.Sub)
                                        .foregroundStyle(.dotchiLgray)
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 17)
                            }
                            .padding(.top, 35)
                        }
                        
                        HStack(alignment: .bottom) {
                            VStack {
                                if let todayCards = homeViewModel.homeResult?.result.todayCards, todayCards.count > 1 {
                                    let secondToday = todayCards[1]
                                    
                                    ForEach([secondToday], id: \.cardId) { today in
                                        Button(action: {
                                            selectedCardId = today.cardId
                                            isDetailPresented = true
                                        }) {
                                            AsyncImageView(url: URL(string: today.cardImageUrl ?? ""))
                                                .scaledToFill()
                                                .frame(width: 82, height: 82)
                                                .cornerRadius(25)
                                                .padding(.bottom, 10)
                                        }
                                        .fullScreenCover(isPresented: Binding(
                                            get: { isDetailPresented },
                                            set: { isDetailPresented = $0; selectedCardId = nil }
                                        )) {
                                            DotchiDetailViewControllerRepresentable(cardId: selectedCardId ?? 0)
                                                .transition(.move(edge: .trailing))
                                                .ignoresSafeArea()
                                        }
                                        
                                        Text(today.backName)
                                            .font(.Sub)
                                            .foregroundStyle(Color.dotchiWhite)
                                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                            .background(
                                                RoundedRectangle(cornerRadius: 67)
                                                    .fill(Color.dotchiLBlack)
                                                    .frame(height: 30)
                                            )
                                        
                                        Text("2위")
                                            .font(.Sub_Sbold)
                                            .foregroundStyle(Color.dotchiGray)
                                            .padding(.top, 5)
                                    }
                                } else {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color.dotchiBlack5)
                                            .frame(width: 82, height: 82)
                                        
                                        Image(.imgClover)
                                            .resizable()
                                            .frame(width: 38, height: 51)
                                            .scaledToFit()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    RoundedRectangle(cornerRadius: 67)
                                        .fill(Color.dotchiLBlack)
                                        .frame(width: 82, height: 30)
                                    
                                    Text("2위")
                                        .font(.Sub_Sbold)
                                        .foregroundStyle(Color.dotchiGray)
                                        .padding(.top, 5)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack {
                                if let todayCards = homeViewModel.homeResult?.result.todayCards, todayCards.count > 0 {
                                    let firstToday = todayCards[0]
                                    
                                    ForEach([firstToday], id: \.cardId) { today in
                                        ZStack(alignment: .top) {
                                            Button(action: {
                                                selectedCardId = today.cardId
                                                isDetailPresented = true
                                            }) {
                                                AsyncImageView(url: URL(string: today.cardImageUrl ?? ""))
                                                    .scaledToFill()
                                                    .frame(width: 112, height: 112)
                                                    .cornerRadius(30)
                                                    .padding(.bottom, 10)
                                            }
                                            .fullScreenCover(isPresented: Binding(
                                                get: { isDetailPresented },
                                                set: { isDetailPresented = $0; selectedCardId = nil }
                                            )) {
                                                DotchiDetailViewControllerRepresentable(cardId: selectedCardId ?? 0)
                                                    .transition(.move(edge: .trailing))
                                                    .ignoresSafeArea()
                                            }
                                            
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color.dotchiGreen, lineWidth: 2)
                                                .frame(width: 112, height: 112)
                                            
                                            Image(.icnPlus)
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                                .offset(y: -30)
                                        }
                                        
                                        Text(today.backName)
                                            .font(.Sub)
                                            .foregroundStyle(Color.dotchiWhite)
                                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                            .background(
                                                RoundedRectangle(cornerRadius: 67)
                                                    .fill(Color.dotchiLBlack)
                                                    .frame(height: 30)
                                            )
                                        
                                        Text("1위")
                                            .font(.Sub_Sbold)
                                            .foregroundStyle(Color.dotchiWhite)
                                            .padding(.top, 5)
                                    }
                                } else {
                                    ZStack(alignment: .top) {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color.dotchiBlack5)
                                            .frame(width: 112, height: 112)
                                        
                                        Image(.imgClover)
                                            .resizable()
                                            .frame(width: 51, height: 68)
                                            .scaledToFit()
                                            .padding(.top, 25)
                                        
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.dotchiGreen, lineWidth: 2)
                                            .frame(width: 112, height: 112)
                                        
                                        Image(.icnPlus)
                                            .resizable()
                                            .frame(width: 64, height: 64)
                                            .offset(y: -30)
                                    }
                                    .padding(.bottom, 10)
                                    
                                    RoundedRectangle(cornerRadius: 67)
                                        .fill(Color.dotchiLBlack)
                                        .frame(width: 114, height: 30)
                                    
                                    Text("1위")
                                        .font(.Sub_Sbold)
                                        .foregroundStyle(Color.dotchiWhite)
                                        .padding(.top, 5)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack {
                                if let todayCards = homeViewModel.homeResult?.result.todayCards, todayCards.count > 2 {
                                    let thirdToday = todayCards[2]
                                    
                                    ForEach([thirdToday], id: \.cardId) { today in
                                        Button(action: {
                                            selectedCardId = today.cardId
                                            isDetailPresented = true
                                        }) {
                                            AsyncImageView(url: URL(string: today.cardImageUrl ?? ""))
                                                .scaledToFill()
                                                .frame(width: 82, height: 82)
                                                .cornerRadius(25)
                                                .padding(.bottom, 10)
                                        }
                                        .fullScreenCover(isPresented: Binding(
                                            get: { isDetailPresented },
                                            set: { isDetailPresented = $0; selectedCardId = nil }
                                        )) {
                                            DotchiDetailViewControllerRepresentable(cardId: selectedCardId ?? 0)
                                                .transition(.move(edge: .trailing))
                                                .ignoresSafeArea()
                                        }
                                        
                                        Text(today.backName)
                                            .font(.Sub)
                                            .foregroundStyle(Color.dotchiWhite)
                                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                            .background(
                                                RoundedRectangle(cornerRadius: 67)
                                                    .fill(Color.dotchiLBlack)
                                                    .frame(height: 30)
                                            )
                                        
                                        Text("3위")
                                            .font(.Sub_Sbold)
                                            .foregroundStyle(Color.dotchiGray)
                                            .padding(.top, 5)
                                    }
                                } else {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color.dotchiBlack5)
                                            .frame(width: 82, height: 82)
                                        
                                        Image(.imgClover)
                                            .resizable()
                                            .frame(width: 38, height: 51)
                                            .scaledToFit()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    RoundedRectangle(cornerRadius: 67)
                                        .fill(Color.dotchiLBlack)
                                        .frame(width: 82, height: 30)
                                    
                                    Text("3위")
                                        .font(.Sub_Sbold)
                                        .foregroundStyle(Color.dotchiGray)
                                        .padding(.top, 5)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 26)
                    }
                    .background(
                        Rectangle()
                            .fill(Color.dotchiBlack3)
                            .padding(.bottom, -25)
                    )
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("따봉도치 둘러보기")
                                .font(.Head)
                                .foregroundStyle(.dotchiWhite)
                            
                            Text("다양한 따봉도치들을 만나보세요")
                                .font(.Sub)
                                .foregroundStyle(.dotchiLgray)
                                .padding(.top, 0.5)
                        }
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: BrowseViewControllerRepresentable()
                                .toolbar(.hidden, for: .navigationBar)
                                .ignoresSafeArea()
                        ) {
                            HStack {
                                Text("전체보기")
                                    .font(.Sub)
                                    .foregroundStyle(.dotchiLgray)
                                
                                Image(.icnNext)
                                    .frame(width: 14, height: 14)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 12) {
                            ForEach(homeViewModel.homeResult?.result.recentCards ?? [], id: \.cardId) { card in
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
                                                    .position(x: geometry.size.width * 0.5,
                                                              y: geometry.size.height * 0.46)
                                            }
                                            
                                            Image(getFrontImageName(forThemeId: card.themeId))
                                                .resizable()
                                                .frame(width: 143, height: 211)
                                        }
                                        
                                        Text(card.backName)
                                            .font(.Dotchi_Name2)
                                            .foregroundStyle(card.themeType.colorFont())
                                            .padding(.bottom, 16)
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
                        .padding(.top, 20)
                    }
                    .padding(.leading, 20)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("테마별 따봉도치.zip")
                                .font(.Head)
                                .foregroundStyle(.dotchiWhite)
                            
                            Text("나에게 필요한 행운 테마를 선택하세요!")
                                .font(.Sub)
                                .foregroundStyle(.dotchiLgray)
                                .padding(.top, 0.5)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 47)
                    
                    HStack {
                        HStack {
                            NavigationLink(destination: CollectionView(themeId: 2)) {
                                ZStack(alignment: .bottomTrailing) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(LuckyType.lucky.name())
                                                .font(.Head2)
                                                .foregroundColor(LuckyType.lucky.colorNormal())
                                            
                                            Text("을")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                                .padding(.leading, -6)
                                        }
                                        
                                        HStack {
                                            Text("나누는 도치들")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                            
                                            Image(.icnNextWhite)
                                        }
                                        
                                        ForEach(homeViewModel.homeResult?.result.themes ?? [], id: \.themeId) { theme in
                                            if theme.themeId == 2 { //행운
                                                Text("\(timeAgoSinceDate(theme.lastCardCreateAt))")
                                                    .font(.Sub)
                                                    .foregroundStyle(Color.dotchiWhite)
                                                    .opacity(0.5)
                                                    .padding(.top, 1)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                    .padding(.leading, -10)
                                    .padding(.top, -20)
                                    
                                    Image(LuckyType.lucky.imageName())
                                        .resizable()
                                        .frame(width: 75, height: 69)
                                        .padding(.bottom, -35)
                                        .padding(.trailing, -15)
                                }
                                .frame(width: 162, height: 162)
                                .background(Color.dotchiBlack2)
                                .cornerRadius(12)
                            }
                        }
                        
                        HStack {
                            NavigationLink(destination: CollectionView(themeId: 4)) {
                                ZStack(alignment: .bottomTrailing) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(LuckyType.love.name())
                                                .font(.Head2)
                                                .foregroundColor(LuckyType.love.colorNormal())
                                            
                                            Text("을")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                                .padding(.leading, -6)
                                        }
                                        
                                        HStack {
                                            Text("나누는 도치들")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                            
                                            Image(.icnNextWhite)
                                        }
                                        
                                        ForEach(homeViewModel.homeResult?.result.themes ?? [], id: \.themeId) { theme in
                                            if theme.themeId == 4 { //애정운
                                                Text("\(timeAgoSinceDate(theme.lastCardCreateAt))")
                                                    .font(.Sub)
                                                    .foregroundStyle(Color.dotchiWhite)
                                                    .opacity(0.5)
                                                    .padding(.top, 1)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                    .padding(.leading, -10)
                                    .padding(.top, -20)
                                    
                                    Image(LuckyType.love.imageName())
                                        .resizable()
                                        .frame(width: 87, height: 63)
                                        .padding(.bottom, -35)
                                        .padding(.trailing, -15)
                                }
                                .frame(width: 162, height: 162)
                                .background(Color.dotchiBlack2)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.leading, 5)
                    }
                    .padding(.top, 26)
                    .padding(.bottom, 6)
                    
                    HStack {
                        HStack {
                            NavigationLink(destination: CollectionView(themeId: 1)) {
                                ZStack(alignment: .bottomTrailing) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(LuckyType.health.name())
                                                .font(.Head2)
                                                .foregroundColor(LuckyType.health.colorNormal())
                                            
                                            Text("을")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                                .padding(.leading, -6)
                                        }
                                        
                                        HStack {
                                            Text("나누는 도치들")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                            
                                            Image(.icnNextWhite)
                                        }
                                        
                                        ForEach(homeViewModel.homeResult?.result.themes ?? [], id: \.themeId) { theme in
                                            if theme.themeId == 1 { //건강운
                                                Text("\(timeAgoSinceDate(theme.lastCardCreateAt))")
                                                    .font(.Sub)
                                                    .foregroundStyle(Color.dotchiWhite)
                                                    .opacity(0.5)
                                                    .padding(.top, 1)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                    .padding(.leading, -10)
                                    .padding(.top, -20)
                                    
                                    Image(LuckyType.health.imageName())
                                        .resizable()
                                        .frame(width: 85, height: 56)
                                        .padding(.bottom, -30)
                                        .padding(.trailing, -15)
                                }
                                .frame(width: 162, height: 162)
                                .background(Color.dotchiBlack2)
                                .cornerRadius(12)
                            }
                        }
                        
                        HStack {
                            NavigationLink(destination: CollectionView(themeId: 3)) {
                                ZStack(alignment: .bottomTrailing) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(LuckyType.money.name())
                                                .font(.Head2)
                                                .foregroundColor(LuckyType.money.colorNormal())
                                            
                                            Text("을")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                                .padding(.leading, -6)
                                        }
                                        
                                        HStack {
                                            Text("나누는 도치들")
                                                .font(.Head2)
                                                .foregroundColor(.dotchiWhite)
                                            
                                            Image(.icnNextWhite)
                                        }
                                        
                                        ForEach(homeViewModel.homeResult?.result.themes ?? [], id: \.themeId) { theme in
                                            if theme.themeId == 3 { //재물운
                                                Text("\(timeAgoSinceDate(theme.lastCardCreateAt))")
                                                    .font(.Sub)
                                                    .foregroundStyle(Color.dotchiWhite)
                                                    .opacity(0.5)
                                                    .padding(.top, 1)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 15)
                                    .padding(.leading, -10)
                                    .padding(.top, -20)
                                    
                                    Image(LuckyType.money.imageName())
                                        .resizable()
                                        .frame(width: 73, height: 77)
                                        .padding(.bottom, -35)
                                        .padding(.trailing, -15)
                                }
                                .frame(width: 162, height: 162)
                                .background(Color.dotchiBlack2)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.leading, 5)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .padding(.bottom, 20)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Spacer()
                            Image(.imgLogo)
                                .resizable()
                                .frame(width: 65, height: 22)
                            Spacer()
                        }
                    }
                }
                .navigationBarColor(backgroundColor: .dotchiBlack3)
            }
        }
        .onAppear() {
            homeViewModel.fetchHome()
        }
    }
    
    // 시간 차이 계산하는 함수
    private func timeAgoSinceDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: Date())
            
            if let days = components.day, days > 0 {
                return "\(days)일전"
            } else if let hours = components.hour, hours > 0 {
                return "\(hours)시간전"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes)분전"
            } else {
                return "방금전"
            }
        }
        
        return ""
    }
}

// 네비게이션바 배경색 변경
struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

#Preview {
    HomeView()
}

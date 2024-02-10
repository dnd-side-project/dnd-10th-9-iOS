//
//  ContentView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import SwiftUI

enum Tab {
    case home
    case my
}

struct ContentView: View {
    @State var isPresented = false
    @State var selectedTab: Tab = .home
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                case .home:
                    HomeView()
                    
                case .my:
                    MyView()
                }
                
                ZStack {
                    CustomTabView(selectedTab: $selectedTab)
                    
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.dotchiGreen)
                                .frame(width: 58, height: 58)
                            
                            Image(.icnPlus)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        }
                        .offset(y: -30)
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        UIViewControllerToSwiftUI( BrowseViewController())
                            .ignoresSafeArea()
                    }
                }
            }
        }
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Button {
                selectedTab = .home
            } label: {
                VStack {
                    Image(selectedTab == .home ? .icnHomeFill : .icnHomeFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text("홈")
                        .foregroundStyle(Color.white)
                        .padding(.top, 3)
                }
            }
            
            Spacer()
            Spacer()
            
            Button {
                selectedTab = .my
            } label: {
                VStack {
                    Image(selectedTab == .my ? .icnPersonFill: .icnPersonFill)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text("마이")
                        .foregroundStyle(Color.white)
                        .padding(.top, 3)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

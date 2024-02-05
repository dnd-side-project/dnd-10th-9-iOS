//
//  ContentView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import SwiftUI

enum Tab {
    case home
    case plus
    case profile
}

struct ContentView: View {
    @State var selectedTab: Tab = .home
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .plus:
                    Spacer()
                    Text("게시글 올리기")
                        .foregroundStyle(Color.white)
                case .profile:
                    Spacer()
                    Text("마이페이지")
                        .foregroundStyle(Color.white)
                }
                
                Spacer()
                
                CustomTabView(selectedTab: $selectedTab)
            }
        }
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(Color.black)
                .frame(height: 84)
            
            HStack {
                Spacer()
                
                Button {
                    selectedTab = .home
                } label: {
                    VStack {
                        Image(selectedTab == .home ? "home_fill" : "home_fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                        
                        Text("홈")
                            .foregroundStyle(Color.white)
                            .padding(.top, 3)
                    }
                }
                
                Spacer()
                
                Button {
                    selectedTab = .plus
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.dotchiGreen)
                            .frame(width: 58, height: 58)
                        
                        Image(selectedTab == .plus ? "plus" : "plus")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    }
                    .offset(y: -30)
                }
                
                Spacer()
                
                Button {
                    selectedTab = .profile
                } label: {
                    VStack {
                        Image(selectedTab == .profile ? "person_fill" : "person_fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                        
                        Text("마이")
                            .foregroundStyle(Color.white)
                            .padding(.top, 3)
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

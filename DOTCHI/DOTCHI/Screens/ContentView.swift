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
    @State var selectedTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .my:
                    MyView()
                }
            }
            .padding(.bottom, -25)
            
            ZStack {
                GeometryReader { geometry in
                    createTabShape(size: geometry.size)
                        .fill(Color.black)
                }
                .frame(height: 100)
                
                CustomTabView(selectedTab: $selectedTab)
            }
            .padding(.bottom, -10)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func createTabShape(size: CGSize) -> Path {
        var path = Path()
        
        let height: CGFloat = 20
        let cornerRadius: CGFloat = 16
        let centerWidth = size.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))
        
        path.addCurve(
            to: CGPoint(x: centerWidth, y: -height),
            control1: CGPoint(x: (centerWidth - 35), y: 0),
            control2: CGPoint(x: centerWidth - 25, y: -height)
        )
        
        path.addCurve(
            to: CGPoint(x: (centerWidth + height * 2), y: 0),
            control1: CGPoint(x: centerWidth + 25, y: -height),
            control2: CGPoint(x: (centerWidth + 35), y: 0)
        )
        
        path.addRoundedRect(
            in: CGRect(x: 0, y: 0, width: size.width, height: size.height),
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        return path
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    @State var isPresented = false
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            
            Button(action: {
                selectedTab = .home
            }){
                VStack {
                    Image(selectedTab == .home ? .icnHome : .icnHome)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                    
                    Text("홈")
                        .foregroundStyle(Color.white)
                        .font(.S_Sub)
                }
                .opacity(selectedTab == .home ? 1.0 : 0.5)
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.isPresented.toggle()
            }) {
                Image(.icnPlus)
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 58)
                
            }
            .offset(y: -20)
            .fullScreenCover(isPresented: $isPresented) {
                UIViewControllerToSwiftUI(BrowseViewController())
                    .ignoresSafeArea()
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                selectedTab = .my
            }){
                VStack {
                    Image(selectedTab == .home ? .icnMy : .icnMy)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                    
                    Text("마이")
                        .foregroundStyle(Color.white)
                        .font(.S_Sub)
                }
                .opacity(selectedTab == .my ? 1.0 : 0.5)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ContentView()
}

//
//  HomeView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
           Color.dotchiBlack.ignoresSafeArea()
            
            ScrollView {
                Text("메인 홈")
                    .foregroundStyle(Color.white)
                    .padding(.top, 300)
            }
        }
    }
}

#Preview {
    HomeView()
}

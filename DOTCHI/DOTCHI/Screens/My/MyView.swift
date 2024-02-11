//
//  MyView.swift
//  DOTCHI
//
//  Created by yubin on 2/6/24.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        ZStack {
           Color.backgroundBlack.ignoresSafeArea()
            
            ScrollView {
                Text("마이페이지")
                    .foregroundStyle(Color.white)
                    .padding(.top, 300)
            }
        }
    }
}

#Preview {
    MyView()
}

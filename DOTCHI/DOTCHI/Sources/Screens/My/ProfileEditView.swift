//
//  ProfileEditView.swift
//  DOTCHI
//
//  Created by yubin on 2/22/24.
//

import SwiftUI

struct ProfileEditView: View {
    var body: some View {
        ZStack {
           Color.dotchiBlack.ignoresSafeArea()
            
            ScrollView {
                Text("마이페이지")
                    .foregroundStyle(Color.white)
                    .padding(.top, 300)
            }
        }
    }
}


#Preview {
    ProfileEditView()
}

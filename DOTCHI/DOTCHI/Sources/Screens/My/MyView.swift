//
//  MyView.swift
//  DOTCHI
//
//  Created by yubin on 2/6/24.
//

import SwiftUI

struct MyView: View {
    @State private var isProfileEditViewPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dotchiBlack.ignoresSafeArea()
                
                VStack {
                    Image(.imgDefaultDummy)
                        .cornerRadius(24)
                        .frame(width: 116, height: 116)
                    
                    Text("닉네임일곱글자")
                        .font(.Body)
                        .foregroundColor(Color.dotchiWhite)
                        .padding(.top, 15)
                    
                    Text("따봉도치의 소개글을 작성해주세요!")
                        .font(.Sub_Sbold)
                        .foregroundColor(Color.dotchiLgray)
                        .padding(.top, 10)
                        .padding(.bottom, 31)
                    
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("나의 따봉도치")
                                .font(.Head2)
                                .foregroundStyle(Color.dotchiWhite)
                            
                            Text("14")
                                .font(.Head2)
                                .foregroundStyle(Color.dotchiGreen)
                        }
                        
                        VStack(spacing: 12) {
                            ForEach(1...3, id: \.self) { rowIndex in
                                HStack(alignment: .center, spacing: 12) {
                                    ForEach(1...2, id: \.self) { colIndex in
                                        ZStack(alignment: .bottom) {
                                            ZStack(alignment: .top) {
                                                Image(.imgDefaultDummy)
                                                    .resizable()
                                                    .frame(height: 241)
                                                    .cornerRadius(9.64)
                                                
                                                Image(.imgLuckyFront)
                                                    .resizable()
                                                    .frame(height: 241)
                                                
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 60.25)
                                                        .fill(Color.dotchiDeepGreen)
                                                        .frame(width: 51, height: 20)
                                                    
                                                    HStack(spacing: 0) {
                                                        Image(.imgDefaultDummy)
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 14, height: 14)
                                                            .clipShape(Circle())
                                                        
                                                        Text("오뜨")
                                                            .font(.S_Sub)
                                                            .foregroundStyle(Color.dotchiWhite)
                                                            .padding(.leading, 4)
                                                    }
                                                    .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 12))
                                                }
                                                .padding(.top, 16)
                                            }
                                            
                                            Text("따봉멍멈무")
                                                .font(.Dotchi_Name2)
                                                .foregroundStyle(Color.dotchiDeepGreen)
                                                .padding(.bottom, 20)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.dotchiMgray)
                    ).fullScreenCover(isPresented: $isProfileEditViewPresented, content: {
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
    }
}

#Preview {
    MyView()
}

//
//  CollectionView.swift
//  DOTCHI
//
//  Created by yubin on 2/13/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(.icnBack)
        }
    }
}

struct CollectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedButton: String = "최신순"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dotchiBlack.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        Text("행운" + "을 빌어주는 따봉도치")
                            .font(.Title)
                            .foregroundStyle(Color.dotchiWhite)
                            
                        HStack {
                            Button(action: {
                                selectedButton = "최신순"
                            }) {
                                Text("최신순")
                                    .font(.Head2)
                                    .foregroundColor(selectedButton == "최신순" ? Color.dotchiGreen : Color.dotchiWhite)
                                    .opacity(selectedButton == "최신순" ? 1.0 : 0.5)
                            }
                            
                            Button(action: {
                                selectedButton = "인기순"
                            }) {
                                Text("인기순")
                                    .font(.Head2)
                                    .foregroundColor(selectedButton == "인기순" ? Color.dotchiGreen : Color.dotchiWhite)
                                    .opacity(selectedButton == "인기순" ? 1.0 : 0.5)
                            }
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
                        .padding(.top, 16)
                    }
                }
                .padding(.vertical, 26)
                .padding(.horizontal, 28)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
        }
    }
}

#Preview {
    CollectionView()
}

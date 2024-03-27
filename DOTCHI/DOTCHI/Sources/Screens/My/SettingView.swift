//
//  SettingView.swift
//  DOTCHI
//
//  Created by KimYuBin on 3/17/24.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var myViewModel = MyViewModel()
    @State private var openEdit = false
    
    var body: some View {
        ZStack {
            Color.dotchiBlack5.ignoresSafeArea()
            
            VStack {
                HStack {
                    CustomBackButton()
                    
                    Spacer()
                    
                    Text("설정")
                        .font(.Sub_Title)
                        .foregroundStyle(.dotchiWhite)
                        .padding(.trailing, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                ScrollView {
                    ZStack {
                        AsyncImage(url: URL(string: myViewModel.myResult?.result.member.memberImageUrl ?? "")) { phase in
                            switch phase {
                            case .empty:
                                Image(.imgDefaultDummy)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 116, height: 116)
                                    .cornerRadius(24)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 116, height: 116)
                                    .cornerRadius(24)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                            case .failure:
                                Image(.imgDefaultDummy)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 116, height: 116)
                                    .cornerRadius(24)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                            @unknown default:
                                Image(.imgDefaultDummy)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 116, height: 116)
                                    .cornerRadius(24)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                            }
                        }
                        
                        Button(action: {
                            self.openEdit = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.dotchiBlack4)
                                    .frame(width: 30, height: 30)
                                
                                Image(.icnEdit)
                                    .frame(width: 14, height: 14)
                            }
                        }
                        .offset(x: 50, y: 45)
                        .sheet(isPresented: $openEdit) {
                            ProfileEditView(myViewModel: myViewModel)
                                .transition(.move(edge: .trailing))
                        }
                    }
                    .padding(.top, 30)
                    
                    Text(myViewModel.myResult?.result.member.memberName ?? "")
                        .font(.Body)
                        .foregroundStyle(.dotchiWhite)
                        .padding(.top, 15)
                    
                    let description = myViewModel.myResult?.result.member.description ?? ""
                    
                    if description.count > 20 {
                        let firstLineIndex = description.index(description.startIndex, offsetBy: 20)
                        let firstLine = String(description.prefix(upTo: firstLineIndex))
                        let secondLine = String(description.suffix(from: firstLineIndex))
                        
                        Text(firstLine + "\n" + secondLine)
                            .font(.Sub_Sbold)
                            .foregroundStyle(.dotchiLgray)
                            .padding(.vertical, 4)
                            .multilineTextAlignment(.center)
                    } else {
                        Text(description)
                            .font(.Sub_Sbold)
                            .foregroundStyle(.dotchiLgray)
                            .padding(.top, 4)
                            .padding(.bottom, 24)
                    }
                    
                    Rectangle()
                        .frame(width: .infinity, height: 8)
                        .foregroundStyle(.black)
                        .padding(.vertical, 20)
                    
                    VStack(alignment: .leading) {
                        Text("정보")
                            .font(.Sub_Title)
                            .foregroundStyle(.dotchiWhite)
                        
                        Button(action: {
                            
                        }) {
                            HStack {
                                Text("문의하기")
                                    .font(.Sub_Sbold2)
                                    .foregroundStyle(.dotchiLgray)
                                
                                Spacer()
                                
                                Image(.icnNext)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }
                        .frame(width:.infinity, height: 36)
                        
                        Link(destination: URL(string: "https://www.dnd.ac/project/74")!) {
                            HStack {
                                Text("서비스 이용 약관")
                                    .font(.Sub_Sbold2)
                                    .foregroundStyle(.dotchiLgray)
                                
                                Spacer()
                                
                                Image(.icnNext)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                            .frame(width:.infinity, height: 36)
                        }
                        
                        Link(destination: URL(string: "https://www.dnd.ac/project/74")!) {
                            HStack {
                                Text("개인정보 처리 방침")
                                    .font(.Sub_Sbold2)
                                    .foregroundStyle(.dotchiLgray)
                                
                                Spacer()
                                
                                Image(.icnNext)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                            .frame(width:.infinity, height: 36)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Rectangle()
                        .frame(width: .infinity, height: 8)
                        .foregroundStyle(.black)
                        .padding(.top, 15)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("차단 목록")
                            .font(.Sub_Title)
                            .foregroundStyle(.dotchiWhite)
                        
                        Button(action: {
                            
                        }) {
                            HStack {
                                Text("차단된 계정")
                                    .font(.Sub_Sbold2)
                                    .foregroundStyle(.dotchiLgray)
                                
                                Spacer()
                                
                                Image(.icnNext)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }
                        .frame(width:.infinity, height: 36)
                        .fullScreenCover(isPresented: $openEdit, content: {
                            ProfileEditView(myViewModel: myViewModel)
                                .transition(.move(edge: .trailing))
                        })
                    }
                    .padding(.horizontal, 20)
                    
                    Rectangle()
                        .frame(width: .infinity, height: 8)
                        .foregroundStyle(.black)
                        .padding(.top, 15)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: {
                                
                            }) {
                                Text("로그아웃")
                                    .font(.Sub_Sbold2)
                                    .foregroundStyle(.dotchiLgray)
                                    .underline()
                            }
                            .padding(.bottom, 10)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Button(action: {
                                
                            }) {
                                Text("탈퇴하기")
                                    .font(.Sub_Medium)
                                    .foregroundStyle(.dotchiLgray)
                                    .underline()
                            }
                            .padding(.bottom, 10)
                            
                            Spacer()
                        }
                    }
                    .padding(.all, 20)
                    .padding(.bottom, 10)
                }
            }
        }
        .onAppear() {
            myViewModel.fetchMy(memberId: UserInfo.shared.userID, lastCardId: APIConstants.pagingDefaultValue)
        }
    }
}

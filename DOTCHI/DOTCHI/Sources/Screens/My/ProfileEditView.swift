//
//  ProfileEditView.swift
//  DOTCHI
//
//  Created by yubin on 2/22/24.
//

import UIKit
import SwiftUI

struct CustomCloseButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(.icnClose)
        }
    }
}

struct ProfileEditView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var openPhoto = false
    @State private var image = UIImage()
    @State private var nickname : String
    @State private var introduce : String
    
    @ObservedObject var myViewModel = MyViewModel()
    @ObservedObject var editViewModel = EditViewModel()
    
    init(myViewModel: MyViewModel) {
        self.myViewModel = myViewModel
        _nickname = State(initialValue: myViewModel.myResult?.result.member.memberName ?? "")
        _introduce = State(initialValue: myViewModel.myResult?.result.member.description ?? "")
    }
    
    let nicknameLimit = 7
    let introduceLimit = 40
    
    var body: some View {
        
        let patchMembersRequestDTO: PatchMembersRequestDTO = {
            PatchMembersRequestDTO(
                memberImage: self.image,
                memberName: self.nickname,
                memberDescription: self.introduce
            )
        }()
        
        ZStack {
            Color.dotchiBlack.ignoresSafeArea()
            
            VStack {
                HStack {
                    CustomCloseButton()
                    
                    Spacer()
                    
                    Text("프로필 수정하기")
                        .font(.Sub_Title)
                        .foregroundStyle(Color.dotchiWhite)
                        .padding(.trailing, 20)
                    
                    Spacer()
                }
                
                VStack(alignment: .center, spacing: 0) {
                    ZStack(alignment:.center) {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.dotchiMgray)
                            .frame(width: 132, height: 132)
                        
                        Image(.imgClover)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 80)
                        
                        Image(uiImage: self.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 132, height: 132)
                            .clipped()
                            .cornerRadius(30)
                        
                        Button(action: {
                            self.openPhoto = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.dotchiBlack4)
                                    .frame(width: 32, height: 32)
                                
                                Image(.imgCamera)
                                    .frame(width: 16, height: 14)
                            }
                        }
                        .offset(x: 60, y: 55)
                        .sheet(isPresented: $openPhoto) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        }
                        
                    }
                    .padding(.top, 30)
                    
                    VStack(alignment: .leading) {
                        Text("닉네임을 설정해주세요.")
                            .font(.Sub)
                            .foregroundStyle(Color.dotchiLgray)
                            .padding(.top, 43)
                            .padding(.bottom, 10)
                        
                        TextField("최대 7글자", text: $nickname)
                            .font(.Head2)
                            .foregroundColor(Color.dotchiWhite)
                            .frame(height: 40)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.dotchiMgray)
                            )
                            .onChange(of: nickname) { newValue in
                                if newValue.count > nicknameLimit {
                                    nickname = String(newValue.prefix(nicknameLimit))
                                }
                            }
                        
                        Text("간단한 소개를 작성해주세요.")
                            .font(.Sub)
                            .foregroundStyle(Color.dotchiLgray)
                            .padding(.top, 30)
                            .padding(.bottom, 10)
                        
                        TextField("최대 40글자", text: $introduce, axis: .vertical)
                            .font(.Head2)
                            .foregroundColor(Color.dotchiWhite)
                            .frame(height: 142)
                            .padding(.horizontal, 20)
                            .multilineTextAlignment(.leading)
                            .padding(.top, -40)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.dotchiMgray)
                            )
                            .onChange(of: introduce) { newValue in
                                if newValue.count > introduceLimit {
                                    introduce = String(newValue.prefix(introduceLimit))
                                }
                            }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        editViewModel.fetchEdit(data: patchMembersRequestDTO)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.dotchiGreen)
                                .frame(width:.infinity, height: 52)
                            
                            Text("저장하기")
                                .foregroundStyle(Color.dotchiWhite)
                                .font(.Big_Button)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .onDisappear() {
            myViewModel.fetchMy(memberId: UserInfo.shared.userID, lastCardId: APIConstants.pagingDefaultValue)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

/*
#Preview {
    ProfileEditView()
}
*/

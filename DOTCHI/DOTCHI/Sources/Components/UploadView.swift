//
//  UploadView.swift
//  DOTCHI
//
//  Created by yubin on 2/6/24.
//

import SwiftUI

struct UploadView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
}

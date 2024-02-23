//
//  AsyncImageView.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(fromURL url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    deinit {
        cancellable?.cancel()
    }
}

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL?

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(.imgDefaultDummy)
                    .resizable()
                    .scaledToFill()
            }
        }
        .onAppear {
            if let url = url {
                loader.load(fromURL: url)
            }
        }
    }
}

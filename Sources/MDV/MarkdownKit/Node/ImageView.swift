//
//  ImageView.swift
//  MDV
//
//  Created by OSX on 2025/12/3.
//

import Markdown
import SwiftUI
import UniformTypeIdentifiers

#if os(macOS)
    typealias PlatformImage = NSImage
#else
    typealias PlatformImage = UIImage
#endif

// 图片视图
struct ImageView: View {
    let image: Markdown.Image
    @State private var imageData: Data?
    @State private var isLoading = false

    let shareName = "Share"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let data = imageData,
                let platformImage = PlatformImage(data: data)
            {
                ImageView(from: platformImage, data: data)
            } else if isLoading {
                ProgressView()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
            } else {
                HStack {
                    Image(systemName: "photo")
                    Text(image.source ?? image.plainText)
                        .foregroundColor(.secondary)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .task(id: image.source) {
            await loadImage()
        }
    }

    private func ImageView(from platformImage: PlatformImage, data: Data)
        -> some View
    {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 5) {
                Text(image.title ?? image.plainText)
                Spacer()
                let document = ImageDocument(data: data, name: shareName)
                ShareButtonView(document: document)

                let photo = SharePhoto(
                    image: platformImageView(from: platformImage),
                    name: shareName
                )
                SharePhotoView(photo: photo)

            }.font(.body.bold())
                .buttonStyle(.plain)
                .foregroundColor(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.accentColor.opacity(0.15))
            platformImageView(from: platformImage)
                .resizable()
                .scaledToFit()
                .shadow(radius: 4)
        }
    }

    private func platformImageView(from platformImage: PlatformImage)
        -> SwiftUI.Image
    {
        #if os(macOS)
            Image(nsImage: platformImage)
        #else
            Image(uiImage: platformImage)
        #endif
    }

    private func loadImage() async {
        guard let source = image.source else { return }
        isLoading = true
        do {
            if source.hasPrefix("http://") || source.hasPrefix("https://") {
                imageData = try await loadRemoteImage(from: source)
            } else {
                imageData = try loadLocalImage(from: source)
            }
        } catch {
            imageData = nil
            print("加载图片失败: \(error.localizedDescription)")
        }
        isLoading = false
    }

    private func loadRemoteImage(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        return data
    }

    private func loadLocalImage(from path: String) throws -> Data {
        let fileURL = URL(fileURLWithPath: path)
        return try Data(contentsOf: fileURL)
    }
}

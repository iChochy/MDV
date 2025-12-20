//
//  MDView.swift
//  MDV
//
//  Created by OSX on 2025/12/17.
//

import Markdown
import SwiftUI

public struct MDView: View {
    let md: String

    public init() {
        self.md = Constants.markdownText
    }

    public init(_ md: String) {
        self.md = md
    }

    public var body: some View {
        MarkdownView(markdown: md)
    }

        
    /// 调试，打印 markdown 的树形结构
    /// - Parameter md: markdownText
    public static func debugDescription(_ md: String) {
        MarkdownView.debugDescription(md)
    }

}

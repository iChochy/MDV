//
//  SwiftUIView.swift
//  MDV
//
//  Created by OSX on 2025/12/17.
//

import Markdown
import SwiftUI

public struct MDView: View {
    let md: String

    public init() {
        self.md = """
            #MDV
            **MDV** 是一个开源的 `Markdown` 展示库
            ## 功能特性
            - 支持标题
            - 支持图片
            - 支持表格
            - 支持代码块
            - 支持列表和任务列表
            - 支持删除线 ~~删除的文本~~
            - 支持链接、引用、内联代码、多种样式组合
            ## MDV 使用
            ```bash
            # Add Package 
            https://github.com/ichochy/mdv

            # Import MDV
            import MDV

            # Using MDV 
            MDView(md: markdownText)
            ```
            ---
            ## About
            Blog: [https://ichochy.com](https://ichochy.com)  
            GitHub: [https://github.com/ichochy/mdv](https://github.com/ichochy/mdv) 
            """
    }

    public init(_ md: String) {
        self.md = md
    }

    public var body: some View {
        MarkdownView(markdown: md)
    }
    
    public func debugDescription() {
        let document = Document(parsing: md)
        print(document.debugDescription())
    }
}

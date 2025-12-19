//
//  ContentView.swift
//  iMDV
//
//  Created by OSX on 2025/12/16.
//

import MDV
import SwiftUI

struct ContentView: View {
    @State private var markdownText = """
        # 欢迎使用 MDV
        **MDV** 是一个开源的 `Markdown` 展示库。  
        这是一个使用 `MDV` 库的展示示例。
        
        ## About
        Blog: [https://ichochy.com](https://ichochy.com)  
        GitHub: [https://github.com/ichochy/mdv](https://github.com/ichochy/mdv)  

        ## 功能特性
        - 支持标题
        - 支持图片
        - 支持表格
        - 支持代码块
        - 支持列表和任务列表
        - 支持删除线 ~~删除的文本~~
        - 支持链接、引用、内联代码、多种样式组合

        ---
        ### 图片
        ![Swift Logo](https://swift.org/assets/images/swift.svg)

        ![MDV.jpg](https://image.ichochy.com/Blog/MDV.jpg)

        ### 表格
        | 功能 | 状态 | 优先级 |
        |------|------|--------|
        | 标题 | ✅ | 高 |
        | 列表 | ✅ | 高 |
        | 表格 | ✅ | 中 |
        | 图片 | ✅ | 中 |


        ### 代码示例
        ```swift
        let greeting = "Hello, World!"
        print(greeting)
        ```

        ```python
        def hello():
            print("Hello from Python!")
        ```

        ### 列表
        1. 有序列表项 1
        2. 有序列表项 2
           - 嵌套的无序列表
           - 另一个项目
        3. 有序列表项 3

        ### 任务列表
        - [x] 完成的任务
        - [ ] 未完成的任务
        - [x] 另一个完成的任务
        - [ ] 待办事项

        ### 链接
        访问 [Swift.org](https://swift.org) 了解更多信息。

        ### 引用
        > 这是一个引用块
        > 可以包含多行文本
        > 
        > 甚至可以嵌套其他内容


        ### 内联代码
        使用 `let x = 10` 来声明变量。

        ### 多种样式组合
        这是 **粗体 *和斜体* 组合** 的文本，还有 `代码` 和 [链接](https://apple.com)。
        """
    var body: some View {
        contentLayout
    }

    #if os(macOS)
        // macOS 布局 - 使用 HSplitView
        private var contentLayout: some View {
            HSplitView {
                editorView
                    .frame(minWidth: 300)
                previewView
                    .frame(minWidth: 300)
            }
            .frame(minWidth: 900, minHeight: 600)
        }
    #else
        // iOS 布局 - 使用 TabView 或 GeometryReader
        private var contentLayout: some View {
            GeometryReader { geometry in
                if geometry.size.width > 700 {
                    // iPad 横屏 - 左右分栏
                    HStack(spacing: 0) {
                        editorView
                            .frame(width: geometry.size.width / 2)
                        Divider()
                        previewView
                            .frame(width: geometry.size.width / 2)
                    }
                } else {
                    // iPhone 或 iPad 竖屏 - 使用 Tab 切换
                    TabView {
                        editorView
                            .tabItem {
                                Label("编辑", systemImage: "pencil")
                            }
                        previewView
                            .tabItem {
                                Label("预览", systemImage: "eye")
                            }
                    }
                }
            }
        }
    #endif
    // 编辑器视图
    private var editorView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Markdown 编辑器")
                .font(.headline)
                .padding(.horizontal)
            Divider()
            TextEditor(text: $markdownText)
                .font(.body)
                .padding(8)
        }
    }

    // 预览视图
    private var previewView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("预览")
                .font(.headline)
                .padding(.horizontal)
            Divider()
            ScrollView {
                MDView(markdownText)
                    .padding()
                    .textSelection(.enabled)
            }
        }.task {
            MDView(markdownText).debugDescription()
        }
    }
}

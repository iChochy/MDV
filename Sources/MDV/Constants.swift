//
//  Constants.swift
//  MDV
//
//  Created by OSX on 2025/12/19.
//


public enum Constants{
    public static let markdownText = """
            # MDV
            **MDV** 是一个开源的 `Markdown` 展示库。在 `SwiftUI` 中展示 `Markdown`。
            
            ## 功能特性
            - 支持标题
            - 支持图片
            - 支持表格
            - 支持代码块
            - 支持列表和任务列表
            - 支持删除线 ~~删除的文本~~
            - 支持链接、引用、内联代码、多种样式组合
            
            ## MDV 使用
            ### 1. Add Package   

            打开菜单 `Xcode -> File -> Add Package Dependencies... `

            搜索  `https://github.com/iChochy/MDV` 找到 `MDV`

            然后点击按钮 `Add Package` 添加 `MDV` 


            ### 2. 使用代码示例

            ```swift
            // 导入 MDV
            import MDV
            import SwiftUI

            struct ContentView: View {
                @State private var markdownText = Constants.markdownText
                
                var body: some View {
                    ScrollView {
                        // 使用 MDView
                        MDView(markdownText)
                            .padding()
                    }
                }
            }
            ```
            
            ## About
            Blog: [https://ichochy.com](https://ichochy.com)  
            GitHub: [https://github.com/ichochy/mdv](https://github.com/ichochy/mdv) 
            
            ---
                   
            ## 展示
            
            ### 图片
            ![Swift Logo](https://swift.org/assets/images/swift.svg)
            
            ![Mac.jpg](https://image.ichochy.com/Blog/MDV.jpg)
            
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
}

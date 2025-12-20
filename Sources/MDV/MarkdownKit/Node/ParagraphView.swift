import Markdown
//
//  ParagraphView.swift
//  MDV
//
//  Created by OSX on 2025/12/3.
//

import SwiftUI

// 段落视图
struct ParagraphView: View {
    let paragraph: Paragraph
    
    var body: some View {
        if containsImage {
            mixedContentView
        } else {
            pureTextView
        }
    }
    
    // MARK: - 子视图
    
    /// 纯文本视图
    private var pureTextView: some View {
        Text(attributedString(for: paragraph))
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    /// 混合内容视图(文本+图片)
    private var mixedContentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(paragraph.children.enumerated()), id: \.offset) { _, child in
                if let image = child as? Markdown.Image {
                    ImageView(image: image)
                } else {
                    Text(attributedString(for: child))
                }
            }
        }
    }
    
    // MARK: - 计算属性
    
    /// 检查是否包含图片
    private var containsImage: Bool {
        paragraph.children.contains { $0 is Markdown.Image }
    }
    
    // MARK: - 辅助方法
    
    /// 递归生成富文本
    private func attributedString(for markup: any Markup) -> AttributedString {
        markup.children.reduce(into: AttributedString()) { result, child in
            result += processMarkup(child)
        }
    }
    
    /// 处理单个 Markup 元素
    private func processMarkup(_ child: any Markup) -> AttributedString {
        switch child {
        case let text as Markdown.Text:
            return AttributedString(text.string)
        
        case _ as Markdown.SoftBreak:
            return AttributedString(" ")
            
        case _ as Markdown.LineBreak:
            return AttributedString("\n")
            
        case let strong as Strong:
            return styled(attributedString(for: strong)) {
                $0.font = .body.bold()
            }
            
        case let emphasis as Emphasis:
            return styled(attributedString(for: emphasis)) {
                $0.font = .body.italic()
            }
            
        case let code as InlineCode:
            return styled(AttributedString(code.code)) {
                $0.foregroundColor = Color.pink
                $0.font = .system(.body,design: .monospaced,weight: .bold)
            }
            
        case let link as Markdown.Link:
            return styled(AttributedString(link.plainText)) {
                $0.foregroundColor = .accentColor
                $0.underlineStyle = .single
                if let url = link.destination {
                    $0.link = URL(string: url)
                }
            }
            
        case let strikethrough as Strikethrough:
            return styled(AttributedString(strikethrough.plainText)) {
                $0.strikethroughStyle = .single
            }
            
        default:
            // 递归处理有子元素的 Markup
            return child.childCount > 0 ? attributedString(for: child) : AttributedString()
        }
    }
    
    /// 应用样式的辅助函数
    private func styled(
        _ text: AttributedString,
        apply: (inout AttributedString) -> Void
    ) -> AttributedString {
        var result = text
        apply(&result)
        return result
    }
}

//
//  ContentView.swift
//  MDView
//
//  Created by OSX on 2025/12/16.
//

import MDV
import SwiftUI

struct ContentView: View {
    @State private var markdownText = Constants.markdownText

    var body: some View {
        VStack {
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
        }.task {
            // 调试，打印 markdown 的树形结构
            MDView.debugDescription(self.markdownText)
        }
    }

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
        }
    }
}

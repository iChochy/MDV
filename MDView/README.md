## 这是 `MDV` 包的展示示例。

# MDV
**MDV** 是一个开源的 `Markdown` 展示包。在 `SwiftUI` 中展示 `Markdown`。

## 功能特性
- 支持标题
- 支持图片
- 支持表格
- 支持代码块
- 支持列表和任务列表
- 支持删除线 ~~删除的文本~~
- 支持链接、引用、内联代码、多种样式组合

## MDV 使用
### 1. 添加包   

打开菜单 `Xcode -> File -> Add Package Dependencies... `

搜索  `https://github.com/iChochy/MDV` 找到 `MDV`

然后点击按钮 `Add Package` 添加 `MDV` 


### 2. 使用示例

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

---
## About
Blog: [https://ichochy.com](https://ichochy.com)  
GitHub: [https://github.com/ichochy/mdv](https://github.com/ichochy/mdv)  


---
## 图片
### Mac
![Mac.jpg](https://image.ichochy.com/Blog/Mac.jpg)

### iPad
![Mac.jpg](https://image.ichochy.com/Blog/iPad.jpg)

### iPhone
![Mac.jpg](https://image.ichochy.com/Blog/iPhone.jpg)


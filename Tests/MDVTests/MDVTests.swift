//
//  MDVTests.swift
//  MDV
//
//  Created by OSX on 2025/12/16.
//

import Testing

@testable import MDV

struct MDVTests {
    @MainActor @Test func debugDescription() throws {
        let md = """
        [Blog](https://ichochy.com)  
        [GitHub](https://github.com/ichochy/mdv)
        """
        // 调试，打印 markdown 的树形结构
        MDView.debugDescription(md)
    }
}

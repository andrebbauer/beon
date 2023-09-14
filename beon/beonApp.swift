// 14/09/23

import SwiftUI

@main
struct beonApp: App {
    var body: some Scene {
        WindowGroup {
			FactListView(viewModel: .init())
        }
    }
}

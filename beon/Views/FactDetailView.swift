// 14/09/23

import SwiftUI

struct FactDetailView: View {
	let fact: Fact

    var body: some View {
		VStack {
			Text("id: " + fact.id)
			Text("Source: " + fact.source)
			Text("Type: " + fact.type)
			Text("Updated at: " + fact.updatedAt)
			Text("v: \(fact.v)")
		}
    }
}

#Preview {
	FactDetailView(fact: .mock("1"))
}

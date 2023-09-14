// 14/09/23

import SwiftUI

struct FactListView: View {
	@ObservedObject var viewModel: FactListViewModel

    var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 10) {
					ForEach(viewModel.facts) { fact in
						NavigationLink(destination: FactDetailView(fact: fact)) {
							Text(fact.text)
								.padding()
								.frame(maxWidth: .infinity)
								.background(
									RoundedRectangle(cornerRadius: 20)
										.stroke(Color.black, lineWidth: 2)
								)
						}
					}
				}
			}
			.padding()
			.navigationTitle("Facts")
		}
		.onAppear { viewModel.fetchWithCompletion() }
//		.task {
//			await viewModel.fetchAllFacts()
//		}
    }
}

#Preview {
	FactListView(viewModel: .init(service: MockNetworkService()))
}

class FactListViewModel: ObservableObject {

	@Published var facts: [Fact] = []

	private let service: NetworkServiceProtocol

	init(service: NetworkServiceProtocol = NetworkService()) {
		self.service = service
	}

	@MainActor
	func fetchAllFacts() async {
		if let facts = try? await service.getAllFacts() {
			self.facts = facts
		}
	}

	func fetchWithCompletion() {
		try? service.getAllFacts { [weak self] facts in
			DispatchQueue.main.async {
				self?.facts = facts
			}
		}
	}
}


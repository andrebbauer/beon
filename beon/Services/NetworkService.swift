// 14/09/23

import Foundation

protocol NetworkServiceProtocol {
	func getAllFacts() async throws -> [Fact]
	func getAllFacts(completionHandler: @escaping ([Fact]) -> Void) throws
}

struct BadUrl: Error {}
struct NoData: Error {}

struct NetworkService: NetworkServiceProtocol {
	func getAllFacts() async throws -> [Fact] {
		guard let url = URL(string: "https://cat-fact.herokuapp.com/facts") else { throw BadUrl() }
		let (data, _) = try await URLSession.shared.data(from: url)
		return try JSONDecoder().decode([Fact].self, from: data)
	}

	func getAllFacts(completionHandler: @escaping ([Fact]) -> Void) throws {
		guard let url = URL(string: "https://cat-fact.herokuapp.com/facts") else { throw BadUrl() }
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { data, _, _ in
			if let data,
			   let facts = try? JSONDecoder().decode([Fact].self, from: data) {
				completionHandler(facts)
			}
		}.resume()
	}
}

struct MockNetworkService: NetworkServiceProtocol {
	func getAllFacts(completionHandler: @escaping ([Fact]) -> Void) throws {}
	
	func getAllFacts() async throws -> [Fact] {
		return [
			.mock("1"),
			.mock("2"),
		]
	}
}

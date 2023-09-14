// 14/09/23

import Foundation

struct Fact: Codable, Identifiable {
	let id, user, text: String
	let v: Int
	let source, updatedAt, type, createdAt: String
	let deleted, used: Bool

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case user, text
		case v = "__v"
		case source, updatedAt, type, createdAt, deleted, used
	}
}

extension Fact {
	static func mock(_ id: String) -> Fact {
		.init(id: id, user: "user", text: "text", v: 1, source: "", updatedAt: "", type: "", createdAt: "", deleted: false, used: true)
	}
}

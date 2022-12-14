import Foundation
import Firappuccino

final class Post: NSObject, FDocument, FAnalyticsLoggable {
	
	
	// Required
	var id: String = UUID().uuidStringSansDashes
	var createdAt: Date = Date()
	
	// Your custom properties - MUST be decorated with `@objc` or your apps will crash when extracting `fieldName` strings from `keyPaths`
	@objc var userId: String = ""
	@objc var updatedAt: Date = Date()
	@objc var title: String = ""
	@objc var message: String = ""
	@objc var likedBy: [DocumentID] = []
	
	init(userId: String, title: String, message: String) {
		self.userId = userId
		self.title = title
		self.message = message
	}
	
	static func == (lhs: Post, rhs: Post) -> Bool {
		return lhs.id == rhs.id
	}
	
	var analyticsData: [String : Any] {
		["post_title": title, "created_by": userId, "likes": likedBy.count > 0]
	}
}


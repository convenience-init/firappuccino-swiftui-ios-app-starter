import Foundation
import Combine
import Firappuccino
import FirebaseFirestore
import FirebaseFirestoreSwift


final class PostService: ObservableObject, Identifiable {
	
	private let postRepository = PostRepository()
	
	// creates a publisher for post property so you can subscribe to it
	@Published var post: Post
	
	// store subscriptions so we can cancel them later
	private var cancellables: Set<AnyCancellable> = []
	
	var postID = ""
	
	init(post: Post) {
		self.post = post
		// Set up a binding between an `Post`’s `id` and the `PostService`’s `postID` and store in cancellables
		$post
			.compactMap { $0.id }
			.assign(to: \.postID, on: self)
			.store(in: &cancellables)
	}
	
	/// Updates a post
	func update() async throws {
		try await postRepository.update(post)
	}
	
	/// Removes a post
	func remove() async throws {
		try await postRepository.remove(post)
	}
}

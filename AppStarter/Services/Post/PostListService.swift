import Foundation
import Combine
import Firappuccino
import FirebaseFirestore
import FirebaseFirestoreSwift

final class PostListService: ObservableObject {
	@Published var postRepository = PostRepository()
	@Published var postServices: [PostService] = []
	
	private var cancellables: Set<AnyCancellable> = []
	
	init() {
		// Add a listener to and map every element of the `posts` array in the `postRepository` into an `ExamplePostService`, creating an array of `ExamplePostService`, one for each post list service.

		postRepository.$posts.map { posts in
			posts.map(PostService.init)
		}
		.assign(to: \.postServices, on: self)
		.store(in: &cancellables)
	}
	
	
	/// Writes a new post to `Firestore`
	/// - Parameters:
	///   - post: the `ExamplePost` to upload
	///   - image: optional `UIImage` to attach to the post and store in `FirebaseStorage`
	func addPost(_ post: Post) async throws {
		try await postRepository.add(post)
	}
	
	/// Removes a post
	func removePost(_ post: Post) async throws {
		try await postRepository.remove(post)
	}
	
	/// Updates a post
	func updatePost(_ post: Post) async throws {
		try await postRepository.update(post)
	}
}


import Foundation
import Firappuccino
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFunctions
import Combine

final class PostRepository: ObservableObject {

	@Published var posts: [Post] = []
	@Published var error: NSError? = nil
	
	private lazy var functions = Functions.functions(region: "us-central1")
	
	private var cancellables: Set<AnyCancellable> = []
	
	private var userId = ""
	private let authService = AuthService.shared
	private lazy var store = { return Firappuccino.db }()
	
	init() {
		// assigns `user.id` to `repository.userId` binding the user and repository
		authService.$currentUser
			.compactMap { user in
				user.id
			}
			.assign(to: \.userId, on: self)
			.store(in: &cancellables)
		
		// observes the changes in user on the main thread and then attaches a subscriber using sink(receiveValue:)
		authService.$currentUser
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.get()
			}
			.store(in: &cancellables)
	}
	
	
	/// Sets up a snapshot listener on the `Post` collection and assigns the results to the repository's @Published `examplePosts` array.
	func get() {
		guard !authService.currentUser.isDummy else { return }
		
		Firappuccino.Listener.`listen`(to: Post.self, key: "POSTS_UPDATED") { documents in
			guard let documents = documents else {
				return
			}
			self.posts = documents
		}
	}
	
	func add(_ post: Post) async throws {

			do {
				post.userId = userId
				try await update(post)
			}
			catch let error as NSError {
				self.error = NSError(domain: "xyz.firappuccino.Firappuccino-ExampleApp", code: 666, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
				Firappuccino.logger.error("\(String(describing: self.error))")
				throw error
			}
		
	}

	func update(_ post: Post) async throws {
		let updatedPost = post
		do {
			try await updatedPost.write()
		}
		catch let error as NSError {
			Firappuccino.logger.error("\(String(describing: self.error))")
			self.error = error
			throw error
		}
	}
	
	func remove(_ post: Post) async throws {
		do {
			try await Firappuccino.Destroyer.`destroy`(post)
		}
		catch let error as NSError {
			Firappuccino.logger.error("\(String(describing: self.error))")
			self.error = error
			throw error
		}
	}
}
	



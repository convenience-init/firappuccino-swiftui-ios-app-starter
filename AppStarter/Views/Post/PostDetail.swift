import SwiftUI

struct PostDetail: View {
	@EnvironmentObject var authService: AuthService
	@State var user = AuthService.shared.currentUser
	@State var postService: PostService
	
	var body: some View {
		Text(postService.post.title)
	}
}

//struct PostDetail_Previews: PreviewProvider {
//	static var previews: some View {
//		PostDetail()
//	}
//}

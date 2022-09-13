import SwiftUI
import Firappuccino

struct PostsView: View {
	@EnvironmentObject var postsService: PostListService
	@EnvironmentObject var authService: AuthService
	@State var showingAlert = false
	@State var text = ""
	@State var messageText = ""
	
	var body: some View {
		ZStack(alignment: .top) {
			VStack {
				
				PostListRandomAccessListView(postServices: postsService.postServices)
				
				TextFieldAlertView(text: $text,
					messageText: $messageText,
					isShowingAlert: $showingAlert,
					placeholder: "Add Post Title",
					placeholder2: "Add Post Message",
					title: NSLocalizedString("AddTitle", comment: ""),
					message: NSLocalizedString("AddTitleDesc", comment: ""),
					leftButtonTitle: NSLocalizedString("Cancel", comment: ""),
					rightButtonTitle: NSLocalizedString("Add", comment: ""),
					leftButtonAction: {
						text = ""
						messageText = ""
					},
					rightButtonAction: {
						Task {
							try await postsService.addPost(Post(userId: authService.currentUser.id, title: text, message: messageText))
							text = ""
							messageText = ""
						}
					}
				)
				.frame(width: 0, height: 0)
			}
			.floatingActionButton(color: .green, image: Image(systemName: "plus").foregroundColor(.white)) {
				showingAlert.toggle()
			}
		}
	}
}

//struct PostsView_Previews: PreviewProvider {
//	static var previews: some View {
//		PostsView().environmentObject(PostsService())
//	}
//}

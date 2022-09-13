import SwiftUI


struct MainTabView: View {
	@EnvironmentObject var authService: AuthService
	@EnvironmentObject var postsService: PostListService
	@State var selectedTab: TabName = .posts
	
	var body: some View {
		TabView(selection: $selectedTab) {
			// Example Posts
			PostsView()
				.navigationBarHidden(true)
				.environmentObject(authService)
				.environmentObject(postsService)
				.tabItem {
					TabItem(text: TabName.posts.rawValue, image: "doc.richtext")
				}
				.tag(TabName.posts)
			
			// Example Profile
			AppUserProfile()
				.navigationBarHidden(true)
				.environmentObject(authService)
				.tabItem {
					TabItem(text: TabName.exampleProfile.rawValue, image: "person.crop.circle")
				}
				.tag(TabName.exampleProfile)
		}
	}
}

//struct MainTabView_Previews: PreviewProvider {
//	static var previews: some View {
//		MainTabView()
//	}
//}

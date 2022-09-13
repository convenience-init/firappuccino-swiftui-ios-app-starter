import SwiftUI

struct PostListRandomAccessListView<Content, Data>: View
where Content: View,
	  Data: RandomAccessCollection,
	  Data.Element == PostService {
	let postServices: Data
	let footer: Content
	
	init(postServices: Data, @ViewBuilder footer: () -> Content) {
		self.postServices = postServices
		self.footer = footer()
	}
	
	init(postServices: Data) where Content == EmptyView {
		self.init(postServices: postServices) {
			EmptyView()
		}
	}
	var body: some View {
		List {
			ForEach(postServices) { postService in
				
				NavigationLink(destination: PostDetail(postService: postService)) {
					PostRow(postService: postService)
				}
			}
			.listRowBackground(Color.clear)
			.listRowSeparator(Visibility.hidden)
			.listSectionSeparator(Visibility.hidden)
			footer
			
		}
		.listStyle(.grouped)
		.background(.clear)
		.onAppear {
			UITableView.appearance().backgroundColor = .clear
			UITableViewCell.appearance().contentView.backgroundColor = .clear
			UITableViewCell.appearance().backgroundColor = .clear
		}
	}
}

//struct PostsRandomAccessListView_Previews: PreviewProvider {
//	static var previews: some View {
//		NavigationView {
//			PostListRandomAccessListView(postServices: PostListService().postServices)
//		}
//		.preferredColorScheme(.dark)
//
//		NavigationView {
//			PostListRandomAccessListView(postServices: PostListService().postServices) {
//				Text("This is a footer")
//			}
//		}
//	}
//}

import SwiftUI


struct PostRow: View {
	@State var postService: PostService
	
	var body: some View {
		ZStack {
			HStack(alignment: .top, spacing: 16) {
				VStack(alignment: .leading, spacing: 2) {
					
					Text(postService.post.title)
						.font(.title2.weight(.bold))
						.lineLimit(1)
						.foregroundColor(.white)
					
					Text(postService.post.message)
						.font(.subheadline.weight(.bold))
						.lineLimit(3)
						.foregroundColor(.white)
					
				Spacer()
			}
			.frame(minWidth: 282)
			.overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.white).blendMode(.overlay))
			.aspectRatio(contentMode: .fit)
			.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
		}
	}
}
}

//struct PostRow_Previews: PreviewProvider {
//	static var previews: some View {
//		ExamplePostRow(examplePost: ExamplePost())
//	}
//}

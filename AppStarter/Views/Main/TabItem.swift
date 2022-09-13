import SwiftUI

struct TabItem: View {
	
	let text: String
	let image: String
	
	var body: some View {
		VStack {
			Image(systemName: image)
			Text(text)
		}
	}
}

enum TabName: String, CaseIterable, Codable {
	case posts = "Posts"
	case exampleProfile = "Profile"
}


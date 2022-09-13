import SwiftUI

struct AppUserProfile: View {
	@EnvironmentObject var authService: AuthService
	@State var user = AuthService.shared.currentUser
	
	var body: some View {
		ZStack(alignment: .top) {
			VStack(alignment: .center, spacing: 16) {
				profileImage
				Text("\(user.firstName) \(user.lastName)")
					.font(.title.weight(.bold))
					.lineLimit(3)
					.foregroundColor(.white)
				
				Divider()
					.padding()
				
				VStack(alignment: .leading, spacing: 6) {
					
					Text("Email")
						.font(.title3.weight(.bold))
						.lineLimit(3)
						.foregroundColor(.appCard)
					Text(user.email)
						.font(.headline.weight(.bold))
						.lineLimit(3)
						.foregroundColor(.white)
						.padding([.bottom], 12)
					
					Text("Display name")
						.font(.title3.weight(.bold))
						.lineLimit(3)
						.foregroundColor(.appCard)
					Text(user.displayName)
						.font(.headline.weight(.bold))
						.foregroundColor(.white)
						.padding([.bottom], 12)
					
					Text("Joined on")
						.font(.title3.weight(.bold))
						.lineLimit(3)
						.foregroundColor(.appCard)
					Text(user.createdAt.ISO8601Format())
						.font(.headline.weight(.bold))
						.lineLimit(3)
						.foregroundColor(.white)
						.padding([.bottom], 12)
				}
			}
			.frame(minWidth: 242 , maxWidth: 282, maxHeight: 666, alignment: .top)
			.overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.white).blendMode(.overlay))
			.aspectRatio(contentMode: .fit)
			.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
			.navigationBarHidden(true)
			Spacer()
		}
		.floatingActionButton(color: .green, image: Image(systemName: "person.crop.circle.badge.xmark").foregroundColor(.white)) {
			Task { try? await authService.signout() }
		}
	}
	
	var profileImage: some View {
		ZStack {
			Image(systemName: "circle.fill")
				.resizable()
				.font(.system(size: 66))
				.frame(width: 111, height: 111)
				.blur(radius: 10)
			
			
			VStack {
				AsyncImage(url: URL(string: "https://source.unsplash.com/random/100x100/?guinea+pig"), content: { image in
					image.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 111, height: 111, alignment: .center)
						.cornerRadius(50)
				}, placeholder: {
					Image(uiImage: UIImage(imageLiteralResourceName: "pushImage"))
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 111, height: 111, alignment: .center)
						.cornerRadius(50)
				})
			}
			.overlay(Circle().stroke(Color.white, lineWidth: 1))
		}
	}
}

//struct AppUserProfile_Previews: PreviewProvider {
//	static var previews: some View {
//		AppUserProfile()
//	}
//}

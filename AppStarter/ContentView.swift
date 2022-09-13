import SwiftUI

struct ContentView: View {
	@State private var onboarded: Bool = UserDefaults.standard.bool(forKey: AppConstants.userDefaults.didWalkThroughKey)
	
	var body: some View {
		ZStack {
			
			if !onboarded {
				PageView([WalkThroughContainerView(page: .one), WalkThroughContainerView(page: .two)], finished: $onboarded)
					.edgesIgnoringSafeArea(.all)
			}
			else {
				MainView()
					.environmentObject(PostListService())
					.environmentObject(AuthService.shared)
			}
		}
		.transition(.slide)
	}
}

//struct ContentView_Previews: PreviewProvider {
//	static var previews: some View {
//		ContentView()
//	}
//}

import SwiftUI
/*
 usage:
 
 ```swift
 struct ExampleScreen: View {
 var body: some View {
 NavigationView {
 VStack {
 Text("Floating Action Button")
 }
 .floatingActionButton(color: .green, image: Image(systemName: "plus").foregroundColor(.white)) {
 // action
 print("FAB Tapped")
 }
 .navigationTitle("FAB Destination")
 .navigationBarTitleDisplayMode(.inline)
 }
 }
 }
 ```
 
 */
struct FloatingActionButtonModifier<ImageView: View>: ViewModifier {
	let color: Color // background color of the button
	let image: ImageView // image shown in the button
	let action: () -> Void
	var size: CGFloat = 60 // size of the button circle
	var margin: CGFloat = 15 // distance from screen edges
	@State private var isLoaded = false
	func body(content: Content) -> some View {
		ZStack {
			Color.clear // allows the ZStack to fill the entire screen
			content
			VStack(alignment: .leading) {
				Spacer()
				HStack {
					Spacer()
					button()
						.scaleEffect(isLoaded ? 1.0 : 0.2)
						.offset(x: 0 - margin, y: isLoaded ? 0 - margin : 36)
						.animation(.easeOut(duration: 0.5), value: isLoaded)
				}
			}
		}
		.onAppear {
			isLoaded = true
		}
	}
	
	@ViewBuilder private func button() -> some View {
		image
			.imageScale(.large)
			.frame(width: size, height: size)
			.background(Circle().fill(color))
			.shadow(color: .gray, radius: 2, x: 1, y: 1)
			.onTapGesture(perform: action)
	}
}

extension View {
	public func floatingActionButton<ImageView: View>(
		color: Color,
		image: ImageView,
		action: @escaping () -> Void) -> some View {
			self.modifier(FloatingActionButtonModifier(
				color: color,
				image: image,
				action: action)
			)
		}
}

import Logging
import SwiftUI
import Firappuccino
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
		// Configurate
		
		/// Configuration
		let appConfig = Configuration(
			legacyFPN: true,
			legacyAPIKey: AppConstants.shared.legacyMessagingServerKey,
			imagePath: AppConstants.shared.messagingCustomImagePath,
			iss: AppConstants.shared.iss,
			projectName: AppConstants.shared.projectID!,
			privateKey: AppConstants.shared.privateKeyPath,
			publicKey: AppConstants.shared.publicKeyPath,
			gcmIdKey: AppConstants.shared.gcmMessageIDKey!,
			clientID: AppConstants.shared.clientID!,
			globalOverrideLogLevel: Logger.Level.error
		)
		
		Configurator.configurate(configuration: appConfig)
		
		// for debug
//		UserDefaults.standard.set(false, forKey: AppConstants.userDefaults.didWalkThroughKey)
		return true
	}
}

@main
struct AppMain: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
	@StateObject var authService = AuthService.shared
	@StateObject var postService = PostListService()
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				ContentView()
			}
			.environmentObject(authService)
			.environmentObject(postService)
			.onAppear {
				FAuth.onAuthStateChanged(ofType: AppUser.self) { user in
					guard let user = user, !user.isDummy else { return }
					if authService.isSignupComplete == false {
						Task {
							user.progress = 0
							user.firstName = authService.firstName
							user.lastName = authService.lastName
							
							try? await user.updateDisplayName(to: user.firstName, ofUserType: AppUser.self)
							
							try await user.write()
							
							authService.currentUser = user
							authService.firstName = ""
							authService.lastName = ""
							authService.isSignupComplete = true
						}
					}
					else {
						authService.currentUser = user
					}
					
					//FPN Messaging
					if let userId = Auth.auth().currentUser?.uid {
						authService.pushManager = FPNManager(userID: userId)
						Task {
							try? await authService.pushManager?.registerForPushNotifications()
						}
					}
					return
				}
			}
		}
	}
}


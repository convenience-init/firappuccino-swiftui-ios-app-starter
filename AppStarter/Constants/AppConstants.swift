import UIKit

struct AppConstants {
	
	struct userDefaults {
		static let didWalkThroughKey = "didWalkThrough"
	}
	
	static let clientID = "YOUR_CLIENT_ID"
	
	static let googleAppID = "YOUR_GOOGLE_APP_ID"
	
	static let gcmSenderID =  "YOUR_GCM_SENDER_ID"
	static let gcmMessageIDKey = "gcm.message_id"
	
	static let apiKey = "YOUR_API_KEY"

	static let messagingCustomImagePath = Bundle.main.url(forResource: "pushImage", withExtension: ".png")?.absoluteString
	
	static let privateKeyPath = Bundle.main.url(forResource: "messageSendPrivate", withExtension: "._key")?.relativePath
	
	static let publicKeyPath = Bundle.main.url(forResource: "messageSendPublic", withExtension: "._key")?.relativePath
	
	static let projectID = "YOUR_PROJECT_ID"
	
	static let legacyMessagingAPIKey = "YOUR_LEGACY_MESSAGING_API_KEY"
	
	static let iss = "YOUR_TOKEN_ISSUER"
	
	static let placeholderProfileImageUrl = URL(string: "YOUR_REMOTE_DEFAULT_PROFILE_IMAGE_URL_STRING")!
	
	static let placeholderPostImageUrl = URL(string: "YOUR_REMOTE_PLACEHOLDER_IMAGE_URL_STRING")!
	
}


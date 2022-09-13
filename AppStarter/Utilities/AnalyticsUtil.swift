import Foundation
import Firebase
import Firappuccino
import FirebaseAnalytics

// - note: Please customize this file to send `FANalytics` events to Firebase Analytics.

struct AnalyticsUtil: FAnalyticsLoggable {
	var parameters = Parameters(property1: "", property2: "")
	var analyticsData: [String : Any] = [:]
	
	struct Parameters: FAnalyticsParamsModelable {
		let property1: String?
		let property2: String?
		
		func toModel(properties: Any ...) -> [String: Any] {
			return [:]
		}
	}
	
	enum EventType: String {
		case onboarded
		case user
		case app
	}
	
	static func logEvent(_ event: EventType, params: Parameters? = nil) {
#if DEBUG
		print("Don't send events...")
#else
		Analytics.logEvent(event.rawValue, parameters: params?.toObject() ?? [:])
#endif
		
	}
}

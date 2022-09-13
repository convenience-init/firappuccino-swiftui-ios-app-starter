import Foundation

enum AuthenticationType: String {
	case login
	case signup
	
	var text: String {
		rawValue.capitalized
	}
	
	var assetBackgroundName: String {
		self == .login ? "login" : "login"
	}
	
	var footerText: String {
		switch self {
			case .login:
				return "Not a member? Signup -> "
				
			case .signup:
				return "Already a member? Login -> "
		}
	}
}

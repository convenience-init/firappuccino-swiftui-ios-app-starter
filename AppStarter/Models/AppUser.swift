import Foundation
import Firappuccino

final class AppUser: UserBase {
	
	@objc var firstName: String = ""
	@objc var lastName: String = ""
	
	enum CodingKeys: String, CodingKey {
		case firstName, lastName
	}
	
	required init() {
		super.init()
	}
	
	required init(from decoder: Decoder) throws {
		try super.init(from: decoder)
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		firstName = try values.decode(String.self, forKey: .firstName)
		lastName = try values.decode(String.self, forKey: .lastName)
	}
	
	override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(firstName, forKey: .firstName)
		try container.encode(lastName, forKey: .lastName)
	}
}

import SwiftData
import Foundation

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var theme: String
    var currency: String
    var password: String

    init(id: UUID, name: String, email: String, theme: String, currency: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.theme = theme
        self.currency = currency
        self.password = password
    }
}

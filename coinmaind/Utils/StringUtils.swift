import Foundation

public func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
}

public func isValidName(_ name: String) -> Bool {
    let nameRegex = "^[A-Za-z ]{4,}$"
    return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
}

public func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-\\[\\]{};':\"\\\\|,.<>/?~]).{8,}$"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
}

import SwiftUI
import iOSDesignSystem

struct LoginView: View {
    
    enum Field: Hashable {
        case email
        case password
    }
    
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    
    @EnvironmentObject var router: Router
    
    @EnvironmentObject private var themeManager: ThemeManager
    
    private func handleAction() {
        if email.isEmpty {
            focusedField = .email
        } else if password.isEmpty {
            focusedField = .password
        } else {
            focusedField = nil
        }
    }
    
    private func navigateToSignUp() {
        router.navigate(to: .signupName)
    }
    
    private func navigateToHome() {
        router.navigate(to: .home)
    }
    
    var body: some View {
        DSContainer(headerProps: DSHeaderProps(
            renderTitle: {
                AnyView(Logo())
            }),
                    content:  {
            VStack {
     
                Text("Log In")
                    .font(themeManager.current.headlineH3)
                    .padding(.bottom)
                
                DSInputField(
                    inputProps: DSInputProps(
                        text: $email,
                        placeholder: "Enter your email",
                        title: "Email",
                        rightIcon: "at"
                    )
                )
                .focused($focusedField, equals: .email)
                .padding(.bottom)
                
                DSInputField(
                    inputProps: DSInputProps(
                        text: $password,
                        placeholder: "Enter your password",
                        isSecure: true,
                        title: "Password"
                    )
                )
                .focused($focusedField, equals: .password)
                .padding(.bottom)
                
                DSButton(
                    buttonProps: DSButtonProps(
                        title: "Log In",
                        variant: .primary,
                        action: navigateToHome
                    )
                )
                
                Button(action: navigateToSignUp) {
                    Text("Don't have an account? Sign Up")
                        .font(themeManager.current.linkLarge)
                        .foregroundColor(themeManager.current.primary)
                }
                .padding(.vertical, 32)
                
                Button(action: navigateToSignUp) {
                    Text("Having trouble logging in?")
                        .font(themeManager.current.linkLarge)
                        .foregroundColor(themeManager.current.secondary)
                }
                
            }
            .padding()
        },
                    alignCenter: true)
    }
}

#Preview {
    LoginView()
        .environmentObject(ThemeManager())
}

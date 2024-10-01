import SwiftUI
import iOSDesignSystem

struct SignupPasswordView: View {
    
    enum Field: Hashable {
        case password
        case confirmPassword
    }
    
    @EnvironmentObject var router: Router
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @FocusState private var focusedField: Field?
    
    @State private var password = ""
    
    @State private var confirmPassword = ""
    
    @State private var passwordError: String? = nil
    
    @State private var confirmPasswordError: String? = nil
    
    private func navigateToNext() {
        
        let isPasswordValid = validatePassword()
        let isConfirmPasswordValid = validateConfirmPassword()
        
        if !isPasswordValid {
            return focusedField = .password
        }
        
        if !isConfirmPasswordValid {
            return focusedField = .confirmPassword
        }
        
        router.navigate(to: .home)
    }
    
    private func validatePassword() -> Bool {
        if password.isEmpty {
            passwordError = "You must enter a Password"
            return false
        }
        
        if !isValidPassword(password) {
            passwordError = "Your Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number"
            return false
        }
        
        return true
    }
    
    private func validateConfirmPassword() -> Bool {
        if confirmPassword.isEmpty {
            confirmPasswordError = "You must enter a Confirm Password"
            return false
        }
        
        if confirmPassword != password {
            confirmPasswordError = "Your Passwords must match"
            return false
        }
        
        return true
    }
    
    var body: some View {
        DSContainer(
            headerProps: DSHeaderProps(
                onBackButtonPressed: {
                    router.navigateBack()
                }
            ),
            primaryButtonProps: DSContainerButtonProps(title: "Next", action: navigateToNext)
            
        ) {
            DSCircularIconButton(
                buttonProps: DSCircularIconButtonProps(
                    systemImageName: "key",
                    variant: .primary,
                    action: {},
                    size: .lg
                )
            )
            Text("Enter your Password")
                .font(themeManager.current.headlineH3)
            
            DSInputField(
                inputProps: DSInputProps(
                    text: $password,
                    placeholder: "Enter a Password",
                    isSecure: true,
                    errorMessage: passwordError,
                    title: "Password"
                )
            )
            .focused($focusedField, equals: .password)
            .onChange(of: password) {
                passwordError = nil
            }
            .onAppear {
                focusedField = .password
            }
            .onSubmit {
                _ = validatePassword()
                
                focusedField = .confirmPassword
                
            }
            
            DSInputField(
                inputProps: DSInputProps(
                    text: $confirmPassword,
                    placeholder: "Confirm your Password",
                    isSecure: true,
                    errorMessage: confirmPasswordError,
                    title: "Confirm Password"
                )
            )
            .focused($focusedField, equals: .confirmPassword)
            .onChange(of: password) {
                confirmPasswordError = nil
            }
            .onSubmit {
                let isValid = validateConfirmPassword()
                
                if isValid {
                    navigateToNext()
                }
                
            }
            .padding(.bottom)
            
        }
    }
}

#Preview {
    SignupPasswordView()
        .environmentObject(ThemeManager())
}

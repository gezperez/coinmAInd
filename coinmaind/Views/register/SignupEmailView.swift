import SwiftUI
import iOSDesignSystem

struct SignupEmailView: View {
    
    enum Field: Hashable {
        case email
    }
    
    @EnvironmentObject var router: Router
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @FocusState private var focusedField: Field?
    
    @State private var email = ""
    
    @State private var emailError: String? = nil
    
    private func navigateToNext() {
        
        let isValid = validateEmail()
        
        if (!isValid) {
            return focusedField = .email
        }
        
        return router.navigate(to: .signupPassword)
    }
    
    private func validateEmail() -> Bool {
        if email.isEmpty {
            emailError = "You must enter a Email"
            return false
        }
        
        if !isValidEmail(email) {
            emailError = "You must enter a valid Email"
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
                    systemImageName: "at",
                    variant: .primary,
                    action: {},
                    size: .lg
                )
            )
            Text("Enter your Email")
                .font(themeManager.current.headlineH3)
            
            DSInputField(
                inputProps: DSInputProps(
                    text: $email,
                    placeholder: "Enter your Email",
                    errorMessage: emailError,
                    title: "Email",
                    rightIcon: "at"
                )
            )
            .focused($focusedField, equals: .email)
            .onChange(of: email) {
                emailError = nil
            }
            .onAppear {
                focusedField = .email
            }
            .onSubmit {
                let isValid = validateEmail()
                
                if (isValid) {
                    navigateToNext()
                }
                
            }
            .padding(.bottom)
            
        }
    }
}

#Preview {
    SignupEmailView()
        .environmentObject(ThemeManager())
}

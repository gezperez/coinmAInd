import SwiftUI
import iOSDesignSystem

struct SignupNameView: View {
    
    enum Field: Hashable {
        case name
    }
    
    @EnvironmentObject var router: Router
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @FocusState private var focusedField: Field?
    
    @State private var name = ""
    
    @State private var nameError: String? = nil
    
    
    private func navigateToNext() {
        let isValid = validateName()
        
        if !isValid {
            return focusedField = .name
        }
        
        router.navigate(to: .signupEmail)
    }
    
    private func validateName() -> Bool {
        if name.isEmpty {
            nameError = "You must enter a Name"
            return false
        }
        
        if !isValidName(name) {
            nameError = "Name must be at least 4 letters and contain no numbers."
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
                    systemImageName: "person",
                    variant: .primary,
                    action: {},
                    size: .lg
                )
            )
            Text("Enter your Name")
                .font(themeManager.current.headlineH3)
            
            DSInputField(
                inputProps: DSInputProps(
                    text: $name,
                    placeholder: "Enter your Name",
                    errorMessage: nameError,
                    title: "Name",
                    rightIcon: "user"
                )
            )
            .focused($focusedField, equals: .name)
            .onChange(of: name) {
                nameError = nil
            }
            .onAppear {
                focusedField = .name
            }
            .onSubmit {
                let isValid = validateName()
                
                if (isValid) {
                    navigateToNext()
                }
            }
            .padding(.bottom)
            
        }
    }
}

#Preview {
    SignupNameView()
        .environmentObject(ThemeManager())
}

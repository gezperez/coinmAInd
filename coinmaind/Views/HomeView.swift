import SwiftUI
import iOSDesignSystem

struct HomeView: View {
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        DSContainer(
            headerProps: DSHeaderProps(
                title: "Home",
                onBackButtonPressed: {
                    router.navigateBack()
                }
            ),
            primaryButtonProps: DSContainerButtonProps(title: "Primary Button", action: {
                router.navigate(to: .onboarding)
            })
        ) {
            ForEach(0..<10) { _ in
                Text("This is the main content area.")
                    .font(.body)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(CornerRadius.md.rawValue)
            }
        }
    }
}

import SwiftUI
import iOSDesignSystem

struct SplashView: View {
    @EnvironmentObject var router: Router
    
    @EnvironmentObject var themeManager: ThemeManager
    
    let hasSeenOnboardingKey = "hasSeenOnboarding"
    let userSessionKey = "userSession"
    
    var body: some View {
        VStack {
            Logo(variant: .splash)
                .onAppear {
                    checkAppStateAndNavigate()
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.current.primary)
    }
    
    func checkAppStateAndNavigate() {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: hasSeenOnboardingKey)
        
        let hasSession = UserDefaults.standard.bool(forKey: userSessionKey)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !hasSeenOnboarding {
                router.navigate(to: .onboarding)
            } else if hasSession {
                router.navigate(to: .home)
            } else {
                router.navigate(to: .login)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(ThemeManager())
}

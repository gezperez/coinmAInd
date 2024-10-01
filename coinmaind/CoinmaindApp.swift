import SwiftUI
import SwiftData
import iOSDesignSystem

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case onboarding
        case home
        case login
        case signupName
        case signupEmail
        case signupPassword
        
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        print(navPath.count)
        if navPath.count > 0 {
            navPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}

@main
struct CoinmaindApp: App {
    @ObservedObject var router = Router()
    
    @ObservedObject var themeManager = ThemeManager()
    
    @Environment(\.colorScheme) var colorScheme
    
    let hasSeenOnboardingKey = "hasSeenOnboarding"
    
    func shouldShowOnboarding() -> Bool {
        return !UserDefaults.standard.bool(forKey: hasSeenOnboardingKey)
    }
    
    func markOnboardingAsShown() {
        UserDefaults.standard.set(true, forKey: hasSeenOnboardingKey)
    }
    
    private func renderFirstScreen() -> some View {
        Group {
            if shouldShowOnboarding() {
                OnboardingView()
                    .onDisappear {
                        markOnboardingAsShown()
                    }
            } else {
                LoginView()
            }
        }
    }
    
    init() {
        iOSDesignSystem.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                renderFirstScreen()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                            case .home:
                                HomeView()
                            case .onboarding:
                                OnboardingView()
                            case .login:
                                LoginView()
                            case .signupName:
                                SignupNameView()
                            case .signupEmail:
                                SignupEmailView()
                            case .signupPassword:
                                SignupPasswordView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(ThemeManager())
        }
    }
}

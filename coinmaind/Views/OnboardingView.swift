import SwiftUI
import iOSDesignSystem

struct OnboardingStep {
    let imageName: String
    let title: String
    let body: String
}

struct OnboardingView: View {
    @EnvironmentObject var router: Router
    
    @StateObject private var themeManager = ThemeManager()
    
    @State private var currentStepIndex = 0
    
    let steps: [OnboardingStep] = [
        OnboardingStep(imageName: "onboarding1", title: "Welcome to coinmAInd", body: "The easiest way to track your spending with the help of AI!"),
        OnboardingStep(imageName: "onboarding2", title: "Add Expenses Using Natural Language", body: "Quickly add your expenses by simply typing or speaking. Our AI understands what you mean. Try something like, ‘I spent $50 on groceries today’ – coinmAInd will handle the rest!"),
        OnboardingStep(imageName: "onboarding3", title: "Get Personalized Spending Summaries", body: "Wondering how much you’ve spent this month? Just ask! coinmAInd provides personalized summaries of your expenses, helping you stay on top of your budget."),
        OnboardingStep(imageName: "onboarding4", title: "Ready to Get Started?", body: "You're all set! Start tracking your expenses and get AI-powered insights today.")
    ]
    
    private func showNextStep() {
        if currentStepIndex < steps.count - 1 {
            withAnimation {
                currentStepIndex += 1
            }
        }
    }
    
    private func navigateToLogin() {
        router.navigate(to: .login)
    }
    
    private func createAttributedString(from text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        
        if let rangeAI = attributedString.range(of: "AI") {
            attributedString[rangeAI].font = themeManager.current.headlineH3
            attributedString[rangeAI].foregroundColor = themeManager.current.secondary
        }
        
        return attributedString
    }
    
    init() {
            // Change the active (current) page indicator color
        UIPageControl
            .appearance().currentPageIndicatorTintColor = UIColor.purple
            
            // Change the inactive page indicators color
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        }
    
    var body: some View {
        DSContainer(
            content: {
                GeometryReader { geometry in
                    VStack {
                        DSSteps(
                            stepsProps: DSStepsProps(
                                currentStep: $currentStepIndex,
                                totalSteps: steps.count
                            )
                        )
                        .padding(.vertical, 24)
                        TabView(selection: $currentStepIndex) {
                            ForEach(0..<steps.count, id: \.self) { index in
                                VStack {
            
                                    ZStack {
                                        RoundedRectangle(cornerRadius: CornerRadius.md.rawValue)
                                            .fill(themeManager.current.surfaceDisabled)
                                        
                                        Image(steps[index].imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .padding(16)
                                    }
                                    .frame(height: geometry.size.height / 2)
                                    .padding(.bottom, 16)
                                    
                             
                                    Text(createAttributedString(from: steps[index].title))
                                        .font(themeManager.current.headlineH3)
                                        .foregroundColor(themeManager.current.onBackground)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                        
                                    Text(steps[index].body)
                                        .font(.system(size: 18))
                                        .foregroundColor(themeManager.current.onBackground)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 8)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 32)
                                .tag(index)
                            }
                        }
                        .tabViewStyle(
                            PageTabViewStyle(indexDisplayMode: .never)
                        )
                        .frame(maxWidth: .infinity)
                        
                     
                        
                        Spacer()
                        
                        HStack {
                            if currentStepIndex < steps.count - 1 {
                                
                                Button(action: navigateToLogin) {
                                    Text("Skip")
                                        .font(themeManager.current.linkLarge)
                                        .foregroundColor(themeManager.current.primary)
                                }
                            }
                            
                            Spacer()
                            
                            if currentStepIndex < steps.count - 1 {
                                DSCircularIconButton(
                                    buttonProps: DSCircularIconButtonProps(
                                        systemImageName: "arrow.forward",
                                        variant: .primary,
                                        action: showNextStep,
                                        size: .md
                                    )
                                )
                            } else {
                                DSButton(
                                    buttonProps: DSButtonProps(
                                        title: "Start",
                                        variant: .primary,
                                        action: navigateToLogin,
                                        fullWidth: false
                                    )
                                )
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                    .padding(.bottom, 32)
                }
            },
            alignCenter: true
        )
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Router()) // Provide environment object
}

import Foundation
import iOSDesignSystem
import SwiftUICore

struct LogoScheme {
    var primaryForeground: Color
    var primaryFont: Font
    var secondaryForeground: Color
    var secondaryFont: Font
}

struct LogoSchemeProvider {
    func logoScheme(themeManager: ThemeManager, variant: LogoVariant) -> LogoScheme {
        switch variant {
            case .splash:
                return LogoScheme(
                    primaryForeground: themeManager.current.onPrimary,
                    primaryFont: themeManager.current.headlineH3,
                    secondaryForeground: themeManager.current.secondary,
                    secondaryFont: themeManager.current.headlineH2
                )
            case .header:
                return LogoScheme(
                    primaryForeground: themeManager.current.onBackground,
                    primaryFont: themeManager.current.headlineH4,
                    secondaryForeground: themeManager.current.secondary,
                    secondaryFont: themeManager.current.headlineH4
                )
        }
    }
}

public enum LogoVariant {
    case splash
    case header
}

struct Logo: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var logoProvider = LogoSchemeProvider()
    private var variant: LogoVariant
    
    init(variant: LogoVariant = .header) {
        self.variant = variant
    }
    
    private func createAttributedString(from text: String) -> AttributedString {
        let values = logoProvider.logoScheme(
            themeManager: themeManager,
            variant: variant
        )
        
        var attributedString = AttributedString(text)
        
        if let rangeAI = attributedString.range(of: "AI") {
            attributedString[rangeAI].font = values.secondaryFont
            attributedString[rangeAI].foregroundColor = values.secondaryForeground
        }
        
        return attributedString
    }
    
    var body: some View {
        let values = logoProvider.logoScheme(
            themeManager: themeManager,
            variant: variant
        )
        
        Text(createAttributedString(from: "coinmAInd"))
            .font(values.primaryFont)
            .foregroundColor(values.primaryForeground)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

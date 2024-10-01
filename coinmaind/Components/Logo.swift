import Foundation
import iOSDesignSystem
import SwiftUICore

struct Logo: View {
    
    @StateObject private var themeManager = ThemeManager()
    
    private func createAttributedString(from text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        
        if let rangeAI = attributedString.range(of: "AI") {
            attributedString[rangeAI].font = themeManager.current.headlineH4
            attributedString[rangeAI].foregroundColor = themeManager.current.secondary
        }
        
        return attributedString
    }
    
    
    var body: some View {
        Text(createAttributedString(from: "coinmAInd"))
            .font(themeManager.current.headlineH5)
            .foregroundColor(themeManager.current.onBackground)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

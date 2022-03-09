import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 16, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
        
    }
}

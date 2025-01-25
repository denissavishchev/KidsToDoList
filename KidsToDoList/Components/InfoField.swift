import SwiftUI

struct InfoField: View {
    
    let title: String
    @Binding var text: String
    @FocusState var isTyping: Bool
    
    var body: some View {
        ZStack(alignment: .leading){
            
            TextField("", text: $text)
                .padding(.leading)
                .frame(height: 55)
                .focused($isTyping)
                .background(isTyping ? .blue : .primary, in: RoundedRectangle(cornerRadius: 14)
                    .stroke(lineWidth: 2))
            Text(title)
                .padding(.horizontal, 5)
                .background(.blue.opacity(isTyping || !text.isEmpty ? 1 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(isTyping ? .black : .primary)
                .padding(.leading)
                .offset(y: isTyping || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isTyping.toggle()
                }
        }
        .animation(.linear(duration: 0.2), value: isTyping)
    }
}



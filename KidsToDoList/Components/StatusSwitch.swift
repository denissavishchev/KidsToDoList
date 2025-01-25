import SwiftUI

struct StatusSwitch: View {
    
    @Binding var isDone: Bool
    
    var body: some View {
        ZStack(alignment: isDone ? .trailing: .leading){
            RoundedRectangle(cornerRadius: 30 )
                .frame(width: 60, height: 60)
                .foregroundColor(isDone ? .green : .pink)
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: isDone ? 5 : 30,
                bottomLeading: isDone ? 5 : 30,
                bottomTrailing: isDone ? 30 : 5,
                topTrailing: isDone ? 30 : 5))
                .foregroundColor(.white)
                .frame(width: 30, height: 54)
                .padding(.top, 3.5)
                .padding(.bottom, 3.5)
                .padding(isDone ? .trailing : .leading, 3)
                .overlay(
                    Image(systemName: isDone ? "sun.min.fill" : "moon.fill")
                        .foregroundColor(isDone ? .green : .pink)
                        .padding(isDone ? .trailing : .leading, 4)
                )
        
        }
        .onTapGesture {
            withAnimation{
                isDone.toggle()
            }
        }
    }
}


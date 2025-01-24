import SwiftUI
import Foundation
import SwiftData

struct TaskTile: View {
    
    @Query var tasks: [Task]
    @Environment(\.modelContext) var mc
    @State private var countdownString: String = ""
    @State var dragOffset = CGSize.zero
    @State var position = CGSize.zero
    @State var position2 = CGSize.zero
    
    var index: Int
    var futureDate: Date
    var name: String
    var description: String
    var image: String
    
    var body: some View {
        VStack{
            ZStack{
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 60,
                    bottomLeading: 60,
                    bottomTrailing: 10,
                    topTrailing: 10
                ))
                
                .frame(maxHeight: 120)
                .foregroundColor(.gray)
                .overlay(
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            Text(formatToDayMonthHHMM(futureDate))
                                .font(.system(size: 12))
                                .bold()
                            Text(countdownString)
                                .onAppear{
                                    startCountdown()
                                }
                                .padding(3)
                                .background(.white, in: RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(6)
                    }
                )
                .padding(.horizontal, 24)
                
                HStack{
                    Circle()
                        .frame(width: 110, height: 110)
                        .foregroundColor(.blue)
                        .padding(.leading, 30)
                    VStack (alignment: .leading){
                        Text(name)
                            .font(.system(size: 20))
                            .bold()
                        .fontDesign(.rounded)
                        Text(description)
                            .font(.system(size: 14))
                            .bold()
                        .fontDesign(.rounded)
                    }
                    Spacer()
                    Circle()
                        .frame(width: 60)
                        .foregroundColor(.black)
                        .padding(.trailing, 6)
                        .padding(.bottom, 70)
                }
                HStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                    .frame(width: 120)
                    .padding(.leading, 6)
                    Spacer()
                }
            }
            .offset(x: dragOffset.width + position.width)
            .animation(.linear, value: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        dragOffset = value.translation
                        position2.width = dragOffset.width + position.width
                    })
                    .onEnded{value in
                        if dragOffset.width < -100{
                            position.width = -180
                        }else{
                            position.width = 0
                        }
                        position2.width = position.width
                        dragOffset = .zero
                    }
            )
            .background(alignment: .trailing, content: {
                HStack(spacing: 18){
                    option(iconName: "pencil.and.outline", iconColor: .orange, action: {}, position2: position2)
                    option(iconName: "bookmark", iconColor: .green, action: {}, position2: position2)
                    option(iconName: "trash", iconColor: .red, action: {delete(index: index)}, position2: position2)
                }
                .padding(.trailing, 30)
            })
        }
    }
    
    func delete(index: Int){
        mc.delete(tasks[index])
    }
    
    private func startCountdown() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let now = Date()
                let timeInterval = futureDate.timeIntervalSince(now)
                
                if timeInterval > 0 {
                    let seconds = Int(timeInterval)
                    countdownString = formatSecondsToDaysHHMMSS(seconds: seconds)
                } else {
                    countdownString = "Time is out"
                    timer.invalidate()
                }
            }
        }
    
    private func formatSecondsToDaysHHMMSS(seconds: Int) -> String {
            let days = seconds / 86400
            let hours = (seconds % 86400) / 3600
            let minutes = (seconds % 3600) / 60
            let remainingSeconds = seconds % 60
            if days > 0 {
                    return String(format: "%d:%02d:%02d:%02d", days, hours, minutes, remainingSeconds)
                } else {
                    return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
                }
        }
    
    func formatToDayMonthHHMM(_ date: Date) -> String {
        let formatterDate = DateFormatter()
        let formatterTime = DateFormatter()
        formatterDate.dateFormat = "dd-MM"
        formatterTime.dateFormat = " HH:mm"
        return "End \(formatterDate.string(from: date)) at \(formatterTime.string(from: date))"
    }
    
}

struct option: View {
    var iconName: String
    var iconColor: Color
    var action: () -> Void
    var position2: CGSize
    var body: some View{
        Button{
            action()
        }label: {
            ZStack{
                Circle()
                    .frame(width: 34, height: 34)
                    .foregroundColor(iconColor.opacity(0.3))
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(iconColor)
            }
        }
        .opacity(min(max(-position2.width / 130, 0), 1))
        .scaleEffect(min(max(-position2.width / 130, 0), 1))
        .animation(.spring, value: position2)
    }
}

#Preview {
    TaskTile(index: 1, futureDate: Date(), name: "Task number one", description: "As far as possible", image: "Piano")
}

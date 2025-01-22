import SwiftUI
import Foundation

struct TaskTile: View {
    
    @State private var countdownString: String = ""
    var futureDate: Date
    
    var body: some View {
        VStack{
            Spacer()
            
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
                        Text("Task number one")
                            .font(.system(size: 20))
                            .bold()
                        .fontDesign(.rounded)
                        Text("As far as possible")
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
                    Image("Bike")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 120)
                    .padding(.leading, 6)
                    Spacer()
                }
            }
            
            Spacer()
        }
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

//#Preview {
//    TaskTile()
//}

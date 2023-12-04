import SwiftUI

struct Home: View {
    @State private var daysElapsed: Int = 0

    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("홈")
                        .padding(30)
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                .padding(.bottom, -30)
                
                Spacer()
                Image("plant1")
                    .resizable()
                    .frame(width: 90, height: 115)
                
                Text("\(daysElapsed)일 째 접속 중")
                            .onAppear {
                                calculateDaysElapsed()
                            }
                Spacer()
                 
                
                
                
            }
        }
    }
    
    func calculateDaysElapsed() {
            let calendar = Calendar.current
            let currentDate = calendar.startOfDay(for: Date())
            
            if let firstDate = UserDefaults.standard.object(forKey: "firstDate") as? Date {
                // 첫 접속 날짜가 이미 저장되어 있을 경우, 저장된 날짜를 가져와 계산
                let firstDateStartOfDay = calendar.startOfDay(for: firstDate)
                let components = calendar.dateComponents([.day], from: firstDateStartOfDay, to: currentDate)
                daysElapsed = components.day ?? 0
            } else {
                // 첫 접속 날짜가 저장되어 있지 않을 경우, 현재 날짜를 저장
                UserDefaults.standard.set(currentDate, forKey: "firstDate")
            }
        }
    
}

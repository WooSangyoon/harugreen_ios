import SwiftUI

struct TodoView: View {
    @ObservedObject var dateManager = DateManager.shared
    
    var dateString: String {
        guard let date = dateManager.clickedDate else { return "날짜 없음" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack{
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 180)
                    .cornerRadius(40)
                    .padding(.top, 15)
                
                 
                VStack(alignment: .leading, spacing: 3){
                    Text("\(dateString)의 목표")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.vertical, 5)
                        .foregroundColor(Color.black)
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            Image(systemName: "circle")
                                .foregroundColor(Color.black)
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("SystemGreen"))
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("SystemGreen"))
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("SystemGreen"))
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("SystemGreen"))
                        }
                        .font(.system(size: 14, weight: .semibold))
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("수업시간에 딴짓하지 않기")
                                .foregroundStyle(Color.black)
                                .lineLimit(1)
                            Text("삼시세끼 꼭 챙겨먹기")
                                .foregroundStyle(Color.gray)
                                .strikethrough()
                                .lineLimit(1)
                            Text("눈 뜨면 바로 일어나기")
                                .foregroundStyle(Color.gray)
                                .strikethrough()
                                .lineLimit(1)
                            Text("전기세 내기")
                                .foregroundStyle(Color.gray)
                                .strikethrough()
                                .lineLimit(1)
                            Text("화장실 청소하기")
                                .foregroundStyle(Color.gray)
                                .strikethrough()
                                .lineLimit(1)
                        }
                        .font(.system(size: 14, weight: .regular))
                        .frame(maxWidth: 300, alignment: .leading)


                    }
                    
                    
                    
                }
                .padding(.top, 10)
            }
            
            
        }
        
    }

}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}

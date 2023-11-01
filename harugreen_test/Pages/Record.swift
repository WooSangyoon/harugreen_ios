import SwiftUI

struct Record: View {
    @State private var date = Date()
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("기록")
                        .padding(30)
                        .font(.system(size: 35, weight: .bold))
                    Spacer()
                }
                .padding(.bottom, -30)
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 380)
                       
                        .cornerRadius(40)
                    CalenderView(month: Date())
                }
            }
            
        }
    }
}

struct Record_Previews: PreviewProvider {
    static var previews: some View {
        Record()
    }
}

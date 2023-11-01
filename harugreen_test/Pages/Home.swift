import SwiftUI

struct Home: View {
    var body: some View {
        ZStack{
            HStack{
                Text("홈")
                    .padding(40)
                    .font(.system(size: 30, weight: .bold))
                Spacer()
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

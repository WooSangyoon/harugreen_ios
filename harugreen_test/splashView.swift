import SwiftUI


struct SplashView: View {
    var body: some View {
        ZStack {
            Color("SystemBackground").ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                Text("하루그린")
                    .font(.title)
                Spacer()
            }
        }
    }
}

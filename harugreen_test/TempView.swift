import SwiftUI

struct ASwiftView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("ASwiftView")
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
            }
        }
    }
}

#Preview {
    ASwiftView()
}

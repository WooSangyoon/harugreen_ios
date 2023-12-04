import SwiftUI

struct ReadingView: View {
    
     var diary: Diary
    
    let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            return formatter
        }()

    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false


    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("SystemBackground")
                .ignoresSafeArea()
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(height: 110)
                    .padding(.top, -60)
            }
            
            Button(action: {
                self.showingAlert.toggle()
            }) {
                Image(systemName: "chevron.backward")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.leading,20)
                    .padding(.top, 13)
                    .imageScale(.small)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
            }
            
            VStack{
                ZStack{
                    HStack {
                        Spacer()
                        Text(formatter.string(from: diary.selectedDate))
                            .font(.system(size: 18, weight: .bold))
                            .padding(.top, 13)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 0)
                
                
                VStack{
                    ZStack{
                        HStack{
                            
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .fill(.white)
                                    .cornerRadius(15)
                                    .frame(width: 280, height: 59)
                                //.padding(5)
                                
                                Text(diary.title)
                                    .padding(.leading, 25)
                                    .font(.system(size:16))
                                    .foregroundColor(.black)
                            }
                            .padding(5)
                            
                            
                            
                            ZStack{
                                
                                ZStack{
                                    Rectangle()
                                        .fill(.white)
                                        .cornerRadius(15)
                                        .frame(width: 59, height: 59)
                                    
                                    Circle()
                                        .fill(Color("SystemGray"))
                                        .frame(width: 43, height: 43)
                                    
                                    
                                    Image(diary.selectedImage)
                                        .resizable()
                                        .frame(width: 33, height: 35)
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    ZStack(alignment: .topLeading){
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(15)
                            .frame(width: 350, height: 630)
                        
                        Text(diary.contents)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .font(.system(size: 16))
                            .padding(10)
                    }
                    .padding(.horizontal, 30)
                }
                
                .padding(.top, 10)
            }
        }
    }
    
}


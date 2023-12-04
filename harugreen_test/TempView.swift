import SwiftUI

struct TempView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    

    
    var body: some View {
        ZStack(alignment: .topLeading) {

            Color("SystemBackground")
                .ignoresSafeArea()
            
            Button(action: {
                self.showingAlert.toggle()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(20)
                    .confirmationDialog("일기 작성 취소", isPresented: $showingAlert,
                                        actions: {
                        Button("작성 중단", role: .destructive) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Button("취소", role: .cancel) {
                            
                        }
                    }, message: { Text("작성 중인 일기는 저장되지 않습니다. 정말로 취소하시겠습니까?") }
                    )
                
            }
            
            VStack{
                HStack {
                    Spacer()
                    Text("오늘의 목표 작성")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 20)
                    
                    Spacer()
                }
                HStack {
                    Spacer()
                        .frame(width: 30)
                    ZStack{
                        Rectangle()
                            .fill(Color("DeepBackground"))
                            .frame(width: 110, height: 40)
                            .cornerRadius(10)
                        HStack{
                            Image(systemName: "archivebox.fill")
                            Text("업무")
                                .font(.system(size: 16, weight: .bold))
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.bottom, 10)
                
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "square.fill")
                        .foregroundColor(Color("SystemGray"))
                    Text("편집본 전달학")
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color("SystemGreen"))
                    Text("동영상 컷편집하기")
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color("SystemGreen"))
                    Text("알바 대타 구하기")
                    Spacer()
                }
                .padding(.bottom, 5)
                // -------------------------------------
                
                HStack {
                    Spacer()
                        .frame(width: 30)
                    ZStack{
                        Rectangle()
                            .fill(Color("DeepBackground"))
                            .frame(width: 110, height: 40)
                            .cornerRadius(10)
                        HStack{
                            Image(systemName: "archivebox.fill")
                            Text("전공")
                                .font(.system(size: 16, weight: .bold))
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    Spacer()
                    
                    
                }
                .padding(.top,20)
                .padding(.bottom, 10)
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "square.fill")
                        .foregroundColor(Color("SystemGray"))
                    Text("전자기학 9주차 과제")
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "square.fill")
                        .foregroundColor(Color("SystemGray"))
                    Text("에너지변환공학 3장 정리")
                    Spacer()
                }
                .padding(.bottom, 5)
                
                
                
                //-------------
                
                
                HStack {
                    Spacer()
                        .frame(width: 30)
                    ZStack{
                        Rectangle()
                            .fill(Color("DeepBackground"))
                            .frame(width: 110, height: 40)
                            .cornerRadius(10)
                        HStack{
                            Image(systemName: "archivebox.fill")
                            Text("대회")
                                .font(.system(size: 16, weight: .bold))
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    Spacer()
                    
                    
                }
                .padding(.top,20)
                .padding(.bottom, 10)
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color("SystemGreen"))
                    Text("발표자료 준비 및 업로드")
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack{
                    Spacer()
                        .frame(width: 32)
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color("SystemGreen"))
                    Text("보고서 작성")
                    Spacer()
                }
                .padding(.bottom, 5)
                }
            
                      

        }
        
        
    }
}

#Preview {
    TempView()
}

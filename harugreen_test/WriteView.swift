import SwiftUI



struct WriteView: View {
    
    @ObservedObject var diariesData: DiariesData

        init(diariesData: DiariesData) {
            self.diariesData = diariesData
        }

    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var selected = "NON"
    
    @State private var showModal = false
    @State private var selectedDate = Date()
    
    @State private var selectedImage = "testemoji1"
    
//    struct Diary: Codable {
//          var title: String
//          var contents: String
//          var selectedDate: Date
//          var selectedImage: String
//      }
    
    @State private var alertType: AlertType?
    
        enum AlertType: Identifiable {
            case uploadError, uploadSuccess
    
            var id: Int {
                switch self {
                case .uploadError:
                    return 1
                case .uploadSuccess:
                    return 2
                }
            }
        }
    


    @State var title: String = ""
    @State var contents: String = ""
    
    let placeholder = "내용을 입력해주세요."
    
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .short
           return formatter
       }
    
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
                ZStack{
                    HStack {
                        Spacer()
                        Text("일기 작성")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.top, 13)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 0)
                
                ScrollView {
                    ZStack{
                        HStack{
                            
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .fill(.white)
                                    .cornerRadius(15)
                                    .frame(width: 260, height: 59)
                                    .padding(5)
                                
                                DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
                                    Text("날짜 선택")
                                        .padding(.leading, 25)
                                        .font(.system(size:16))
                                        .foregroundColor(.black)
                                }
                                
                                .frame(width: 250, height: 59)
                                .accentColor(Color("SystemGreen"))
                            }
                            
                            
                            ZStack{
                                
                                ZStack{
                                    Rectangle()
                                        .fill(.white)
                                        .cornerRadius(15)
                                        .frame(width: 59, height: 59)
                                    
                                    Circle()
                                        .fill(Color("SystemGray"))
                                        .frame(width: 43, height: 43)
                                    
                                    Menu {
                                        Button(action: { selectedImage = "testemoji1" }) {
                                            Image("testemoji1")

                                        }
                                        Button(action: { selectedImage = "testemoji2" }) {
                                            Image("testemoji2")
    
                                        }
                                        Button(action: { selectedImage = "testemoji3" }) {
                                            Image("testemoji3")
 
                                        }
                                        Button(action: { selectedImage = "testemoji4" }) {
                                            Image("testemoji4")

                                        }
                                        Button(action: { selectedImage = "testemoji5" }) {
                                            Image("testemoji5")

                                        }
                                        Button(action: { selectedImage = "testemoji6" }) {
                                            Image("testemoji6")

                                        }
                                    } label: {
                                        Image(selectedImage)
                                            .resizable()
                                            .frame(width: 33, height: 35)
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            .padding(5)
                            .ignoresSafeArea()
                            
                            
                        }
                        .padding(.top, 15)
                        
                    }
                    ZStack(alignment: .leading){
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(15)
                            .frame(width: 338, height: 59)
                        
                        
                        
                        
                        TextField("제목을 입력해주세요.", text: $title)
                            .background(Color.clear)
                            .padding(.leading, 20)
                            .frame(width: 318)
                            .onAppear(perform : UIApplication.shared.hideKeyboard)
                        
                    }
                    
                    
                    ZStack(alignment: .topLeading){
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(15)
                            .frame(width: 338, height: 459)
                            .padding()
                        
                        
                        
                        TextEditor(text: $contents)
                            .padding(30)
                            .frame(width: 368)
                            .onAppear(perform : UIApplication.shared.hideKeyboard)
                        
                        if contents.isEmpty{
                            Text(placeholder)
                                .padding(.top, 38)
                                .padding(.leading, 35)
                                .foregroundColor(Color.primary.opacity(0.2))
                        }
                        
                    }
                    .padding(.top, -8)
                }
                .frame(height: 630)
               
                
                    ZStack{
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    if !title.isEmpty && !contents.isEmpty {
                                        alertType = .uploadSuccess
                                    }
                                    else {
                                        alertType = .uploadError
                                    }
                                    
                                }, label: {
                                    ZStack{
                                        Rectangle()
                                            .fill(title.isEmpty || contents.isEmpty ? Color("SystemGray") : Color("SystemGreen"))
                                            .frame(width: 338, height: 55)
                                            .cornerRadius(13)
                                        Text("작성하기")
                                            .foregroundStyle(title.isEmpty || contents.isEmpty ? Color.gray : Color.white)
                                            .font(.system(size: 18, weight: .bold))
                                    }
                                    .alert(item: $alertType) { type in
                                        switch type {
                                        case .uploadError:
                                            return Alert(
                                                title: Text("작성 오류"),
                                                message: Text("모든 내용을 빠짐없이 작성해 주세요.")
                                            )
                                        case .uploadSuccess:
                                            let SomeButton1 = Alert.Button.destructive(Text("아니오")) {}
                                            let SomeButton2 = Alert.Button.default(Text("예")) {
                                                
                                                let fileManager = FileManager.default
                                                let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                                                let diariesDirectory = documentDirectory.appendingPathComponent("Diaries", isDirectory: true)
                                                let fileURL = diariesDirectory.appendingPathComponent("diary.json")

                                                var diaries = [Diary]()

                                                if fileManager.fileExists(atPath: fileURL.path) {
                                                    do {
                                                        let data = try Data(contentsOf: fileURL)
                                                        let decoder = JSONDecoder()
                                                        decoder.dateDecodingStrategy = .iso8601
                                                        diaries = try decoder.decode([Diary].self, from: data)
                                                    } catch {
                                                        print("기존 JSON 파일을 불러오는데 실패하였습니다.")
                                                    }
                                                }

                                                let newDiary = Diary(title: title, contents: contents, selectedDate: selectedDate, selectedImage: selectedImage)
                                                       diariesData.diaries.append(newDiary)
                                                diaries.append(newDiary)

                                                do {
                                                    let encoder = JSONEncoder()
                                                    encoder.dateEncodingStrategy = .iso8601
                                                    let data = try encoder.encode(diaries)

                                                    if !fileManager.fileExists(atPath: diariesDirectory.path) {
                                                        try fileManager.createDirectory(at: diariesDirectory, withIntermediateDirectories: true, attributes: nil)
                                                    }

                                                    try data.write(to: fileURL, options: .atomic)
                                                    print("JSON 파일이 성공적으로 저장되었습니다.")
                                                    print(fileURL.path)
                                                    
                                                } catch {
                                                    print("JSON 파일 작성에 실패하였습니다.")
                                                }
                                                
                                                
                                                presentationMode.wrappedValue.dismiss()
                                                


                                            }
                                            
                                            return Alert(
                                                title: Text("일기 등록"),
                                                message: Text("정말 일기를 등록하시겠습니까?"),
                                                primaryButton: SomeButton1, secondaryButton: SomeButton2
                                            )
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                })
                                
                                
                                Spacer()
                            }
                        }
                        
                    }
                }
                
                
            

            
        }}
    
}


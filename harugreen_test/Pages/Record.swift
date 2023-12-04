import SwiftUI

struct Diary: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var title: String
    var contents: String
    var selectedDate: Date
    var selectedImage: String
}

class DiariesData: ObservableObject {
    @Published var diaries: [Diary] = []

    func removeDiaries(at offsets: IndexSet, fileURL: URL) {
            // Remove diaries from the array
            diaries.remove(atOffsets: offsets)
            
            // Convert the updated array back to JSON
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            if let encoded = try? encoder.encode(diaries) {
                // Write the updated JSON data back to the file
                do {
                    try encoded.write(to: fileURL)
                } catch {
                    print("JSON 파일에 쓰는데 실패하였습니다: \(error)")
                }
            }
        }

}

struct Record: View {
    
    
    @StateObject var diariesData = DiariesData()
    
    @State private var isShowingWriteView :Bool = false
    @State private var isShowingReadingView :Bool = false
    @State private var fileURL: URL?
    @State private var selectedDiary: Diary?
    @State private var diaries: [Diary] = []
    


    

    let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            return formatter
        }()


    var body: some View {
        
        
        ZStack{
            VStack{
                HStack{
                    Text("기록")
                        .padding(30)
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .padding(30)
                        .imageScale(.large)
                        .foregroundColor(Color("SystemGreen"))
                        .onTapGesture {
                            isShowingWriteView = true
                        }
                        .fullScreenCover(isPresented: $isShowingWriteView) {
                            WriteView(diariesData: diariesData)
                        }
                }
                .padding(.bottom, -30)
                
                
                
                if diariesData.diaries.isEmpty {
                    VStack{
                        Image(systemName: "leaf")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("SystemGray"))
                            .padding(.top, 220)
                        
                        Text("기록된 일기가 없습니다.")
                            .foregroundColor(Color.black.opacity(0.2))
                            .padding(.top, 20)
                    }
                } else {
                    List{
                        Section(header: EmptyView().padding(0)) {
                            ForEach(diariesData.diaries) { diary in
                                ZStack(alignment: .leading){
                                    
                                    
                                    Text(formatter.string(from: diary.selectedDate))
                                        .padding(.leading, 10)
                                        .padding(.bottom, 25)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color("SystemGreen"))
                                    
                                    Text(diary.title)
                                        .padding(.leading, 10)
                                        .padding(.top, 20)
                                        .font(.system(size: 18, weight: .semibold))
                                    
                                    ZStack{
                                        Circle()
                                            .fill(Color("SystemGray"))
                                            .frame(width: 43, height: 43)
                                        
                                        Image(diary.selectedImage)
                                            .resizable()
                                            .frame(width: 33, height: 35)
                                    }
                                    .padding(.leading, 280)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                        isShowingReadingView = true
                                    //check1. 여기서는 정상적으로 작동함.
                                }
                                .fullScreenCover(isPresented: $isShowingReadingView) {
                                    ReadingView(diary : diary)
                                }
                                
            
                            }
                            .onDelete { indexSet in
                                diariesData.removeDiaries(at: indexSet, fileURL: fileURL!)
                            }
                            
                        }
                        
                    }
 
                    .scrollContentBackground(.hidden)
                    .frame(height: 600)

                }
                Spacer()
            }
        }
        .onAppear {
            
            
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let diariesDirectory = documentDirectory.appendingPathComponent("Diaries", isDirectory: true)
            fileURL = diariesDirectory.appendingPathComponent("diary.json")
            print(fileURL!)
            
            
            if fileManager.fileExists(atPath: fileURL!.path) {
                        do {
                            let data = try Data(contentsOf: fileURL!)
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            diariesData.diaries = try decoder.decode([Diary].self, from: data)
                            diariesData.diaries.sort { $0.selectedDate > $1.selectedDate }
                        } catch {
                            print("JSON 파일을 불러오는데 실패하였습니다: \(error)")
                        }
                    }
        }
    }
}


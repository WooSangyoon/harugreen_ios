import SwiftUI

// Diary 구조체 정의
struct Diary: Codable, Identifiable {
    var id = UUID()
    var name: String
    var date: String
    var contents: String
}

// JSON 파일 로드 함수
func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("\(filename) not found.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): \(error)")
    }
}

var diaryData: [Diary] = loadJson("diaryData.json")


class DiaryStore : ObservableObject {
    @Published var diaries: [Diary]
    
    init (diaries: [Diary] = []) {
        self.diaries = diaries
    }
}

// DiaryView 정의
struct DiaryView: View {
    @ObservedObject var diaryStore = DiaryStore(diaries: diaryData)
    
    var body: some View {
        NavigationView {
            List(diaryStore.diaries) { diary in
                VStack(alignment: .leading) {
                    Text(diary.name)
                        .font(.headline)
                    Text(diary.date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationTitle("Diary List")
        }
    }
}

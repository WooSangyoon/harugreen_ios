import SwiftUI

class Memo: Identifiable, ObservableObject {
    let id:UUID  // indentifiable 사용하기 위한 구성요소
    @Published var content : String
    let insertData : Date
    
    init(content:String, insertData:Date = Date.now){
        id=UUID()
        self.content = content
        self.insertData = insertData
    }
}


class MemoStore:ObservableObject{
    @Published var list: [Memo]
    
    init(){
        list=[
            Memo(content: "Hello", insertData: Date.now),
            Memo(content: "Memo", insertData: Date.now.addingTimeInterval(3600 * -24)),
            Memo(content: "awesome", insertData: Date.now.addingTimeInterval(3600 * -48)),
        ]
    }
    
    func insert(memo:String){
            list.insert(Memo(content: memo), at: 0)
        }
        // 새로 입력한 메모는 맨위 위치하게함
        
        func update(memo:Memo?, content:String){
            guard let memo = memo else {
                return
            }
            memo.content = content
        }
        func delete(memo:Memo){
            list.removeAll {$0.id == memo.id}
        }
        func delete(set:IndexSet){
            for index in set{
                list.remove(at: index)
            }
        }
}

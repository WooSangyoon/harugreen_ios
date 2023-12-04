import SwiftUI
import TabBar

struct CustomTabBarStyle: TabBarStyle {
    @Binding var isAnimating: Bool
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .cornerRadius(12)
                .frame(height: 60)
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 4)
                .padding(.horizontal, 25)
                .padding(.bottom, geometry.safeAreaInsets.bottom)

          
            itemsContainer()
                .frame(height: 80)
                .padding(.horizontal, 30)
                .padding(.bottom, 1.0 + geometry.safeAreaInsets.bottom)

        }
    }
    
}

struct CustomTabItemStyle: TabItemStyle {
    
    @Binding var selectedTab: ContentView.Item  // 선택된 탭을 추적하는 @Binding 속성 추가

    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        ZStack {
            Image(systemName: isSelected ? selectedTab.selectedIcon : icon)
                .resizable()
                .aspectRatio(contentMode: .fit) // 이 부분 추가
                .foregroundColor(icon == "paperplane.fill" ? Color.white : (isSelected ? Color(("SystemGreen")) : .gray))
                .frame(width: 24.0, height: 24.0) // 아이콘의 크기 조정
            }
            .padding(.vertical, 14.0)
        }
    }


struct ContentView: View {
    @State private var isAnimating = false
    @State private var isShowingWriteView = false
    
    enum Item: Int, Tabbable {
        case first = 0
        case second
        case third
        case forth
        
        var icon: String {
            switch self {
                case .first:  "house"// Name of icon of first item.
                case .second: "book.closed"// Name of icon of second item.
                case .third:  "trophy"
                case .forth:  "person.crop.circle"
            }
        }
        
        var title: String {
            switch self {
                case .first:  "홈"
                case .second: "선물"
                case .third:  "업적"
                case .forth:  "내정보"

            }
        }
        
        var selectedIcon: String {
            switch self {
            case .first:  "house.fill"
            case .second: "book.closed.fill" // 필요한 경우 변경
            case .third: "trophy.fill"
            case .forth: "person.crop.circle.fill"
            }
        }
    }
    
    @State private var showMainView = false
    @State private var selectedTab = 0
    @State private var currentTab = 0
    @State private var selection: Item = .first
    //@State private var previousSelection: Item = .first
    
    var body: some View {
        ZStack {
            if showMainView {
                TabBar(selection: $selection) {
                    ZStack{
                        Color("SystemBackground").ignoresSafeArea()
                        Home()
                            .tabItem(for: Item.first)
                        
                        
                        Record()
                            .tabItem(for: Item.second)
                        
                        
                       Award()
                        .tabItem(for: Item.third)
                        
                        MypageView()
                            .tabItem(for: Item.forth)
                    }
//                    .onChange(of: selection) { newItem in // TabBar의 selection이 변경될 때마다 동작을 정의합니다.
//                        if newItem == .third { // 세번째 탭 아이템이 선택되었을 때,
//                            isShowingWriteView = true // 새 창을 띄우도록 합니다.
//                            selection = previousSelection
//                        }
//                        else {
//                            previousSelection = selection
//                        }
//                    }
//                    .fullScreenCover(isPresented: $isShowingWriteView, content: WriteView2.init)
                }
                .tabBar(style: CustomTabBarStyle(isAnimating: $isAnimating))
                .tabItem(style: CustomTabItemStyle(selectedTab: $selection))
                     
                
            } else { // 스플래시
                SplashView()
                   .onAppear() {
                       DispatchQueue.main.asyncAfter(deadline:.now() + 0) { withAnimation{ showMainView = true } }
                   }

            }

        }

        
       
    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
        
    }

}



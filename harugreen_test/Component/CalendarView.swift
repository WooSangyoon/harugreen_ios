import SwiftUI

// Singleton 클래스 생성
class DateManager: ObservableObject {
    static let shared = DateManager() // Singleton instance

    @Published var clickedDate: Date? = Calendar.current.startOfDay(for: Date())

    private init() {} // Prevent creating another instance

    func updateDate(date: Date) {
        self.clickedDate = date
    }
}

struct CalenderView: View {
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDate: Date? = Calendar.current.startOfDay(for: Date())
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
        .padding(30)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width < -100 {
                        changeMonth(by: 1)
                    } else if gesture.translation.width > 100 {
                        changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )
    }
  
    private var headerView: some View {
        VStack {
            Text(month.formatted(Date.FormatStyle().month(.wide)))
                .font(.system(size: 30, weight: .bold))
            .padding(.bottom)
          
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .padding(.bottom, 5)
        }
    }
  
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
           
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let clicked = date == clickedDate
                          
                        CellView(day: day, clicked: clicked, date: date)
                            .onTapGesture {
                                self.clickedDate = date
                                DateManager.shared.updateDate(date: date) // 선택한 날짜 업데이트
                            }
                    }
                }
            }
        }
    }
}

private struct CellView: View {
    var day: Int
    var clicked: Bool
    var date : Date

    init(day: Int, clicked: Bool, date: Date) {
        self.day = day
        self.clicked = clicked
        self.date = date
    }
  
    var body: some View {
        VStack {
            Circle()
                .fill(Color("SystemGreen"))
                .frame(width: 40, height: 40)
                .opacity(clicked ? (isToday() ? 1 : 0.2) : 0)
                .overlay(
                    Text(String(day))
                        .font(.system(size: 18, weight: (clicked ? .semibold : .regular)))
                        .foregroundColor(isToday() ? (clicked ? .white : Color("SystemGreen")) : (clicked ? Color("SystemGreen") : .black))
                )
                .foregroundColor(.black)
        }
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let today = calendar.component(.day, from: Date())
        let dayOfDate = calendar.component(.day, from: date)
        return today == dayOfDate
    }
}

private extension CalenderView {
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
  
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
  
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
  
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
  
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}

extension CalenderView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
  
    static let weekdaySymbols = Calendar.current.veryShortWeekdaySymbols
}

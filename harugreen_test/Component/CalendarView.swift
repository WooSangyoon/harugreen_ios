import SwiftUI

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
  
  // MARK: - 헤더 뷰
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
  
  // MARK: - 날짜 그리드 뷰
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
                  clickedDate = clicked ? nil : date
              }
          }
        }
      }
    }
  }
}

// MARK: - 일자 셀 뷰
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
        .fill(Color("IconGreen"))
        .frame(width: 40, height: 40)
        .opacity(clicked ? (isToday() ? 1 : 0.2) : 0)
        .overlay(
            Text(String(day))
                .font(.system(size: 18, weight: (clicked ? .semibold : .regular)))
                .foregroundColor(isToday() ? (clicked ? .white : Color("IconGreen")) : (clicked ? Color("IconGreen") : .black))
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

// MARK: - 내부 메서드
private extension CalenderView {
  /// 특정 해당 날짜
  private func getDate(for day: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
  }
  
  /// 해당 월의 시작 날짜
  func startOfMonth() -> Date {
    let components = Calendar.current.dateComponents([.year, .month], from: month)
    return Calendar.current.date(from: components)!
  }
  
  /// 해당 월에 존재하는 일자 수
  func numberOfDays(in date: Date) -> Int {
    return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
  func firstWeekdayOfMonth(in date: Date) -> Int {
    let components = Calendar.current.dateComponents([.year, .month], from: date)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    
    return Calendar.current.component(.weekday, from: firstDayOfMonth)
  }
  
  /// 월 변경
  func changeMonth(by value: Int) {
    let calendar = Calendar.current
    if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
      self.month = newMonth
    }
  }
}

// MARK: - Static 프로퍼티
extension CalenderView {
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
  }()
  
  static let weekdaySymbols = Calendar.current.veryShortWeekdaySymbols
}

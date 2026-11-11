import SwiftUI

struct MonthView: View {
    let month: Date
    let today: Date
    let status: (Date) -> DayStatus?

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    private let weekdays = Calendar.current.shortWeekdaySymbols.map { $0.uppercased() }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(month.monthTitle)
                .font(.headline)
                .padding(.leading, 12)

            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                ForEach(0..<month.leadingEmptyDays, id: \.self) { _ in
                    Color.clear
                        .frame(height: 44)
                }

                ForEach(month.daysInMonth, id: \.self) { day in
                    DayCircle(
                        date: day,
                        status: status(day),
                        isToday: day.isSameDay(as: today)
                    )
                }
            }
        }
    }
}

#Preview {
    let today = Date.now

    MonthView(month: today, today: today) { day in
        day < today.startOfDay ? .learned : nil
    }
    .padding(.horizontal, 4)
    .preferredColorScheme(.dark)
}

import SwiftUI

struct WeekStripView: View {
    let days: [Date]
    let today: Date
    let status: (Date) -> DayStatus?

    var body: some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.self) { day in
                VStack(spacing: 4) {
                    Text(day.weekdayLetter)
                        .font(.footnote)
                        .fontWeight(.semibold)

                    DayCircle(
                        date: day,
                        status: status(day),
                        isToday: day.isSameDay(as: today)
                    )
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    let today = Date.now

    WeekStripView(days: today.daysOfWeek, today: today) { day in
        day < today.startOfDay ? .learned : nil
    }
    .padding(.horizontal, 14)
    .preferredColorScheme(.dark)
}

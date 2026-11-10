import SwiftUI

struct DayCircle: View {
    let date: Date
    let status: DayStatus?
    var isToday: Bool = false

    var body: some View {
        Text(date.dayNumber)
            .font(.title3)
            .fontWeight(isToday ? .bold : .medium)
            .foregroundStyle(textColor)
            .frame(width: 44, height: 44)
            .background(backgroundColor, in: .circle)
    }

    // MARK: - Colors

    private var textColor: Color {
        switch status {
        case .learned: .brandOrange
        case .frozen: .freezeBlue
        case nil: isToday ? .white : .primary
        }
    }

    private var backgroundColor: Color {
        switch status {
        case .learned: .brandOrange.opacity(0.2)
        case .frozen: .freezeBlue.opacity(0.2)
        case nil: isToday ? .brandOrange : .clear
        }
    }
}

#Preview {
    HStack(spacing: 12) {
        DayCircle(date: .now.adding(days: -2), status: .learned)
        DayCircle(date: .now.adding(days: -1), status: .frozen)
        DayCircle(date: .now, status: nil, isToday: true)
        DayCircle(date: .now.adding(days: 1), status: nil)
    }
    .padding()
    .preferredColorScheme(.dark)
}

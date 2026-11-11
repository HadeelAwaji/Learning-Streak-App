import SwiftUI

struct CalendarView: View {
    @Environment(ActivityViewModel.self) private var viewModel
    @State private var visibleMonth: Date?

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.calendarMonths, id: \.self) { month in
                    VStack(spacing: 0) {
                        MonthView(
                            month: month,
                            today: viewModel.today,
                            status: viewModel.status(for:)
                        )
                        .padding(.vertical, 16)

                        Divider()
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 4)
        }
        .scrollPosition(id: $visibleMonth, anchor: .top)
        .onAppear {
            visibleMonth = viewModel.today.startOfMonth
        }
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let viewModel = ActivityViewModel()
    viewModel.startGoal(subject: "Swift", duration: .week)

    return NavigationStack {
        CalendarView()
    }
    .environment(viewModel)
    .preferredColorScheme(.dark)
}

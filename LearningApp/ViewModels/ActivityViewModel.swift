import Foundation
import Observation

@Observable
final class ActivityViewModel {

    // MARK: - State

    private(set) var goal: LearningGoal?
    private(set) var logs: [DayLog] = []
    private(set) var today: Date = .now

    private var streakStartDate: Date = .now.startOfDay
    private var lastActivityDate: Date?

    // MARK: - Today

    var todayStatus: DayStatus? {
        status(for: today)
    }

    var isTodayLogged: Bool {
        todayStatus != nil
    }

    var weekDays: [Date] {
        today.daysOfWeek
    }

    var headerText: String {
        today.headerText
    }

    func status(for date: Date) -> DayStatus? {
        logs.first { $0.date.isSameDay(as: date) }?.status
    }

    // MARK: - Counters

    var learnedCount: Int {
        count(of: .learned)
    }

    var frozenCount: Int {
        count(of: .frozen)
    }

    var freezeLimit: Int {
        goal?.duration.freezeLimit ?? 0
    }

    private func count(of status: DayStatus) -> Int {
        logs.filter { $0.status == status && $0.date >= streakStartDate }.count
    }

    // MARK: - Texts

    var learnedText: String {
        dayText(for: learnedCount)
    }

    var frozenText: String {
        dayText(for: frozenCount)
    }

    var freezesUsedText: String {
        "\(frozenCount) out of \(freezeLimit) Freezes used"
    }

    private func dayText(for count: Int) -> String {
        count == 1 ? "1 day" : "\(count) days"
    }

    // MARK: - Buttons

    var canLog: Bool {
        !isTodayLogged
    }

    var canFreeze: Bool {
        !isTodayLogged && frozenCount < freezeLimit
    }

    var logButtonTitle: String {
        todayStatus == .learned ? "Logged as Learned" : "Log as Learned"
    }

    var freezeButtonTitle: String {
        todayStatus == .frozen ? "Freezed for a day" : "Freeze for a day"
    }

    // MARK: - Validation

    func isValidSubject(_ subject: String) -> Bool {
        !subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Actions

    func startGoal(subject: String, duration: Duration) {
        guard isValidSubject(subject) else { return }

        let cleanSubject = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        goal = LearningGoal(subject: cleanSubject, duration: duration, startDate: today.startOfDay)
        resetStreak()
    }

    func updateGoal(subject: String, duration: Duration) {
        startGoal(subject: subject, duration: duration)
    }

    func logLearned() {
        refresh()
        guard canLog else { return }
        addLog(.learned)
    }

    func freezeDay() {
        refresh()
        guard canFreeze else { return }
        addLog(.frozen)
    }

    private func addLog(_ status: DayStatus) {
        logs.append(DayLog(date: today, status: status))
        lastActivityDate = today
    }

    private func resetStreak() {
        streakStartDate = today.startOfDay
        lastActivityDate = nil
    }

    // MARK: - Rules

    func refresh() {
        today = .now
        checkStreak()
    }

    private func checkStreak() {
        guard let lastActivityDate else { return }

        if today.hoursSince(lastActivityDate) > 32 {
            resetStreak()
        }
    }

    // MARK: - Goal Result

    var goalState: GoalState {
        guard let goal else { return .inProgress }
        guard today >= goal.endDate else { return .inProgress }

        return isGoalMet(goal) ? .completed : .notMet
    }

    private func isGoalMet(_ goal: LearningGoal) -> Bool {
        let loggedDays = logs.filter {
            $0.date >= goal.startDate && $0.date < goal.endDate
        }.count

        let totalDays = Calendar.current.dateComponents(
            [.day], from: goal.startDate, to: goal.endDate
        ).day ?? 0

        return loggedDays >= totalDays
    }

    // MARK: - Calendar

    var calendarMonths: [Date] {
        let startOfYear = Calendar.current.dateInterval(of: .year, for: today)?.start ?? today
        let firstLog = logs.map(\.date).min() ?? startOfYear
        let lastMonth = startOfYear.adding(months: 11)

        var months: [Date] = []
        var month = min(startOfYear, firstLog).startOfMonth

        while month <= lastMonth {
            months.append(month)
            month = month.adding(months: 1)
        }
        return months
    }
}

// MARK: - Preview Data

#if DEBUG
extension ActivityViewModel {
    static func preview(_ state: GoalState) -> ActivityViewModel {
        let viewModel = ActivityViewModel()

        guard state != .inProgress else {
            viewModel.goal = LearningGoal(subject: "Swift", duration: .week)
            return viewModel
        }

        let start = Date.now.startOfDay.adding(days: -7)
        viewModel.goal = LearningGoal(subject: "Swift", duration: .week, startDate: start)
        viewModel.streakStartDate = start

        for offset in 0..<7 {
            if state == .notMet && offset == 2 { continue }
            let status: DayStatus = (offset == 3 || offset == 4) ? .frozen : .learned
            viewModel.logs.append(DayLog(date: start.adding(days: offset), status: status))
        }

        return viewModel
    }
}
#endif

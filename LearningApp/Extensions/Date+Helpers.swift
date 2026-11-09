//
//  Date+Helpers.swift
//  Learning-App
//
//  Created by Hadeel awaji on 28/05/1448 AH.
//

import Foundation

extension Date {

    // MARK: - Comparing days

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    func hoursSince(_ other: Date) -> Double {
        timeIntervalSince(other) / 3600
    }

    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }

    // MARK: - Week strip

    var daysOfWeek: [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: self)?.start else {
            return []
        }
        return (0..<7).map { startOfWeek.adding(days: $0) }
    }

    var dayNumber: String {
        formatted(.dateTime.day())
    }

    var weekdayLetter: String {
        formatted(.dateTime.weekday(.narrow))
    }

    // MARK: - Header text

    var headerText: String {
        Date.headerFormatter.string(from: self)
    }

    private static let headerFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }()
}

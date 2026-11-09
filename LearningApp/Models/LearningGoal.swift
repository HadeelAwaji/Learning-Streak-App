//
//  LearningGoal.swift
//  Learning-App
//
//  Created by Hadeel awaji on 28/05/1448 AH.
//

import Foundation

struct LearningGoal: Codable {
    var subject: String
    var duration: Duration
    var startDate: Date = Calendar.current.startOfDay(for: .now)

    var endDate: Date {
        Calendar.current.date(
            byAdding: duration.calendarComponent,
            value: 1,
            to: startDate
        ) ?? startDate
    }
}

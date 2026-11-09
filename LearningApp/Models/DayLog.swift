//
//  DayLog.swift
//  Learning-App
//
//  Created by Hadeel awaji on 28/05/1448 AH.
//

import Foundation

struct DayLog: Codable, Identifiable {
    let date: Date
    let status: DayStatus

    var id: Date { date }

    init(date: Date, status: DayStatus) {
        self.date = Calendar.current.startOfDay(for: date)
        self.status = status
    }
}

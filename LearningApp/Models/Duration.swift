//
//  Duration.swift
//  Learning-App
//
//  Created by Hadeel awaji on 28/05/1448 AH.
//

import Foundation

enum Duration: String, CaseIterable, Codable {
    case week
    case month
    case year

    var title: String {
        rawValue.capitalized
    }

    var freezeLimit: Int {
        switch self {
        case .week: return 2
        case .month: return 8
        case .year: return 96
        }
    }

    var calendarComponent: Calendar.Component {
        switch self {
        case .week: return .weekOfYear
        case .month: return .month
        case .year: return .year
        }
    }
}

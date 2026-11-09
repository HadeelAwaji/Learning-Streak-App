//
//  LearningGoalViewModel.swift
//  Learning-App
//
//  Created by Hadeel awaji on 28/05/1448 AH.
//

import Foundation
import Observation

@Observable
final class LearningGoalViewModel {

    // MARK: - Draft

    var subject: String
    var duration: Duration
    var showUpdateAlert = false

    // MARK: - Dependencies

    private let activityViewModel: ActivityViewModel
    private let originalSubject: String
    private let originalDuration: Duration

    // MARK: - Init

    init(activityViewModel: ActivityViewModel) {
        let currentSubject = activityViewModel.goal?.subject ?? ""
        let currentDuration = activityViewModel.goal?.duration ?? .week

        self.activityViewModel = activityViewModel
        self.subject = currentSubject
        self.duration = currentDuration
        self.originalSubject = currentSubject
        self.originalDuration = currentDuration
    }

    // MARK: - Computed

    var hasChanges: Bool {
        let cleanSubject = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleanSubject != originalSubject || duration != originalDuration
    }

    var isStartingNewGoal: Bool {
        activityViewModel.goalState != .inProgress
    }

    var canSave: Bool {
        activityViewModel.isValidSubject(subject) && (hasChanges || isStartingNewGoal)
    }

    // MARK: - Actions

    func checkmarkTapped() -> Bool {
        guard canSave else { return false }

        if isStartingNewGoal {
            saveGoal()
            return true
        }

        showUpdateAlert = true
        return false
    }

    func saveGoal() {
        activityViewModel.updateGoal(subject: subject, duration: duration)
    }
}

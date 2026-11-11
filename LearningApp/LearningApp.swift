import SwiftUI

@main
struct LearningApp: App {
    @State private var activityViewModel = ActivityViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if activityViewModel.goal == nil {
                    OnboardingView()
                } else {
                    ActivityView()
                }
            }
            .environment(activityViewModel)
            .preferredColorScheme(.dark)
        }
    }
}

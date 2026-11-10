import SwiftUI

struct GoalResultView: View {
    let isCompleted: Bool
    let onSetGoal: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(.tint)
                .padding(.bottom, 8)

            Text(title)
                .font(.callout.bold())

            Text(subtitle)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            Button("Set a goal", systemImage: "pencil.and.outline", action: onSetGoal)
                .buttonStyle(.glassProminent)
                .padding(.top, 24)
        }
        .multilineTextAlignment(.center)
    }

    // MARK: - Content

    private var icon: String {
        isCompleted ? "hands.clap.fill" : "xmark.seal"
    }

    private var title: String {
        isCompleted ? "Well done!" : "You didn't reach your goal this time."
    }

    private var subtitle: String {
        isCompleted ? "Ready for your next goal?" : "Want to set another goal?"
    }
}

#Preview {
    VStack(spacing: 60) {
        GoalResultView(isCompleted: true) { }
        GoalResultView(isCompleted: false) { }
    }
    .padding()
    .preferredColorScheme(.dark)
    .tint(.brandOrange)
}

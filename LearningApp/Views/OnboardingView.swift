import SwiftUI

struct OnboardingView: View {
    @Environment(ActivityViewModel.self) private var viewModel

    @State private var subject = ""
    @State private var duration: Duration = .week

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            goalSection
            Spacer()
            startSection
        }
        .padding(.horizontal, 18)
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: "flame.fill")
                .font(.system(size: 36))
                .foregroundStyle(.tint)
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
                .padding(.bottom, 85)

            Text("Hello \(Text("Learner").fontWeight(.bold))")
                .font(.largeTitle)

            Text("This app will help you learn everyday!")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Goal

    private var goalSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("I want to learn")
                .padding(.top, 40)

            TextField("Swift", text: $subject)
                .submitLabel(.done)

            Divider()

            Text("I want to learn it in a")
                .padding(.top, 24)

            DurationPicker(selection: $duration)
        }
    }

    // MARK: - Start

    private var startSection: some View {
        VStack(spacing: 12) {
            Button("Start Learning") {
                viewModel.startGoal(subject: subject, duration: duration)
            }
            .font(.body)
            .buttonStyle(.glassProminent)
            .controlSize(.large)
            .disabled(!viewModel.isValidSubject(subject))

            Text("You can edit your desire later")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    OnboardingView()
        .environment(ActivityViewModel())
        .preferredColorScheme(.dark)
}

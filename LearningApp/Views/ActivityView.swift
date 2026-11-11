import SwiftUI

struct ActivityView: View {
    @Environment(ActivityViewModel.self) private var viewModel
    @Environment(\.scenePhase) private var scenePhase

    @State private var showGoalEditor = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                header

                WeekStripView(
                    days: viewModel.weekDays,
                    today: viewModel.today,
                    status: viewModel.status(for:)
                )

                statCards

                Spacer()
                mainSection
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.top, 8)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $showGoalEditor) {
                LearningGoalView(activityViewModel: viewModel)
            }
        }
        .onAppear { viewModel.refresh() }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active { viewModel.refresh() }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)) { _ in
                    viewModel.refresh()
                }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Activity")
                    .font(.largeTitle.bold())

                Spacer()

                GlassEffectContainer(spacing: 12) {
                    HStack(spacing: 12) {
                        NavigationLink {
                            CalendarView()
                        } label: {
                            headerIcon("calendar")
                        }
                        .accessibilityLabel("Calendar")

                        Button {
                            showGoalEditor = true
                        } label: {
                            headerIcon("pencil.and.outline")
                        }
                        .accessibilityLabel("Learning goal")
                    }
                    .buttonStyle(.plain)
                }
            }

            Text(viewModel.headerText)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private func headerIcon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.title3)
            .foregroundStyle(.primary)
            .frame(width: 44, height: 44)
            .glassEffect(.regular.interactive(), in: .circle)
    }

    // MARK: - Stat Cards

    private var statCards: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                StatCard(icon: "flame.fill", iconColor: .brandOrange,
                         value: viewModel.learnedText, label: "Learned")
                StatCard(icon: "snowflake", iconColor: .freezeBlue,
                         value: viewModel.frozenText, label: "Freezed")
            }
        }
    }

    // MARK: - Main Section

    @ViewBuilder
    private var mainSection: some View {
        switch viewModel.goalState {
        case .inProgress:
            logSection
        case .completed:
            GoalResultView(isCompleted: true) { showGoalEditor = true }
        case .notMet:
            GoalResultView(isCompleted: false) { showGoalEditor = true }
        }
    }

    private var logSection: some View {
        VStack(spacing: 48) {
            LogButton(title: viewModel.logButtonTitle, isEnabled: viewModel.canLog) {
                viewModel.logLearned()
            }

            VStack(spacing: 12) {
                Button {
                    viewModel.freezeDay()
                } label: {
                    Text(viewModel.freezeButtonTitle)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .controlSize(.large)
                .tint(.freezeBlue)
                .frame(width: 272)
                .disabled(!viewModel.canFreeze)

                Text(viewModel.freezesUsedText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    let viewModel = ActivityViewModel()
    viewModel.startGoal(subject: "Swift", duration: .week)

    return ActivityView()
        .environment(viewModel)
        .preferredColorScheme(.dark)
}

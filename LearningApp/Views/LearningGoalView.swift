import SwiftUI

struct LearningGoalView: View {
    @State private var viewModel: LearningGoalViewModel
    @Environment(\.dismiss) private var dismiss

    init(activityViewModel: ActivityViewModel) {
        _viewModel = State(initialValue: LearningGoalViewModel(activityViewModel: activityViewModel))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("I want to learn")

            TextField("Swift", text: $viewModel.subject)
                .submitLabel(.done)

            Divider()

            Text("I want to learn it in a")
                .padding(.top, 24)

            DurationPicker(selection: $viewModel.duration)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .navigationTitle("Learning Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", systemImage: "checkmark") {
                    if viewModel.checkmarkTapped() {
                        dismiss()
                    }
                }
                .disabled(!viewModel.canSave)
            }
        }
        .alert("Update goal", isPresented: $viewModel.showUpdateAlert) {
            Button("Dismiss", role: .cancel) { }
            Button("Update", role: .confirm) {
                viewModel.saveGoal()
                dismiss()
            }
        } message: {
            Text("If you update now, your streak will start over.")
        }
    }
}

#Preview {
    let activityViewModel = ActivityViewModel()
    activityViewModel.startGoal(subject: "Swift", duration: .week)

    return NavigationStack {
        LearningGoalView(activityViewModel: activityViewModel)
    }
    .preferredColorScheme(.dark)
    .tint(.brandOrange)
}

#Preview {
    let activityViewModel = ActivityViewModel()
    activityViewModel.startGoal(subject: "Swift", duration: .week)

    return NavigationStack {
        LearningGoalView(activityViewModel: activityViewModel)
    }
    .preferredColorScheme(.dark)
    .tint(.brandOrange)
}

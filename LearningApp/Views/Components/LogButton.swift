import SwiftUI

struct LogButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body.bold())
                .foregroundStyle(isEnabled ? Color.white : Color.secondary)
                .frame(width: 272, height: 272)
                .glassEffect(
                    isEnabled ? .regular.tint(.brandOrange).interactive() : .regular,
                    in: .circle
                )
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .animation(.smooth, value: isEnabled)
    }
}

#Preview {
    VStack(spacing: 32) {
        LogButton(title: "Log as Learned", isEnabled: true) { }
        LogButton(title: "Logged as Learned", isEnabled: false) { }
    }
    .preferredColorScheme(.dark)
}

import SwiftUI

struct DurationPicker: View {
    @Binding var selection: Duration

    var body: some View {
        GlassEffectContainer {
            HStack(spacing: 12) {
                ForEach(Duration.allCases, id: \.self) { duration in
                    if duration == selection {
                        durationButton(duration)
                            .buttonStyle(.glassProminent)
                    } else {
                        durationButton(duration)
                            .buttonStyle(.glass)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .controlSize(.large)
    }

    private func durationButton(_ duration: Duration) -> some View {
        Button(duration.title) {
            selection = duration
        }
        .font(.body)
    }
}

#Preview {
    @Previewable @State var duration: Duration = .week
    DurationPicker(selection: $duration)
        .padding()
        .preferredColorScheme(.dark)
}

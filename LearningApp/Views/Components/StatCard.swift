import SwiftUI

struct StatCard: View {
    let icon: String
    let iconColor: Color
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(iconColor)
                .padding(.bottom, 4)

            Text(value)
                .font(.headline)

            Text(label)
                .font(.footnote)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .glassEffect(.regular, in: .rect(cornerRadius: 30))
    }
}

#Preview {
    GlassEffectContainer(spacing: 12) {
        HStack(spacing: 12) {
            StatCard(icon: "flame.fill", iconColor: .brandOrange, value: "4 days", label: "Learned")
            StatCard(icon: "snowflake", iconColor: .freezeBlue, value: "0 days", label: "Freezed")
        }
    }
    .padding(.horizontal, 14)
    .preferredColorScheme(.dark)
}

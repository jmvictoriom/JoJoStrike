import SwiftUI

struct CollectionView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Image(systemName: "square.grid.2x2.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.jojoPurple)

                    Text("COLLECTION")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(.jojoPurple)
                        .tracking(6)

                    Text("0 / 30 poses")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Collection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    CollectionView()
}

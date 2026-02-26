import Foundation
import SwiftData

@Observable
@MainActor
final class CurrentProfileProvider {
    var profile: UserProfile?

    func load(userAccountID: String, in context: ModelContext) {
        let descriptor = FetchDescriptor<UserProfile>(
            predicate: #Predicate { $0.userAccountID == userAccountID }
        )
        profile = try? context.fetch(descriptor).first
    }

    func clear() {
        profile = nil
    }
}

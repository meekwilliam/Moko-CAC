import SwiftUI
import Combine

// MARK: - Profile payload (decoded from the JS bridge)

struct ProfileBadge: Decodable, Identifiable {
    let name: String
    let color: String
    let shadow: String
    let icon: String
    let unlocked: Bool
    var id: String { name }
}

struct ProfilePayload: Decodable {
    let userName: String
    let xp: Int
    let streak: Int
    let lessons: Int
    let reminderOn: Bool
    let badges: [ProfileBadge]
}

final class ProfileStore: ObservableObject {
    @Published var userName: String
    @Published var xp: Int
    @Published var streak: Int
    @Published var lessons: Int
    @Published var reminderOn: Bool
    @Published var badges: [ProfileBadge]

    init(payload: ProfilePayload) {
        userName = payload.userName
        xp = payload.xp
        streak = payload.streak
        lessons = payload.lessons
        reminderOn = payload.reminderOn
        badges = payload.badges
    }
}

// MARK: - Legal document (privacy / terms)

struct LegalSection: Decodable, Identifiable {
    let heading: String
    let body: String
    var id: String { heading }
}

struct LegalDoc: Decodable {
    let title: String
    let date: String
    let sections: [LegalSection]
}

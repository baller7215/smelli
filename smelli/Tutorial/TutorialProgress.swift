//
//  TutorialProgress.swift
//  smelli
//

import Foundation
import Observation

@Observable
final class TutorialProgress {
    static let shared = TutorialProgress()

    private let storageKey = "tutorial.completedLessonIDs"

    private(set) var completedLessonIDs: Set<String> = []

    init() {
        if let saved = UserDefaults.standard.array(forKey: storageKey) as? [String] {
            completedLessonIDs = Set(saved)
        }
    }

    func isCompleted(_ lessonID: String) -> Bool {
        completedLessonIDs.contains(lessonID)
    }

    func markCompleted(_ lessonID: String) {
        completedLessonIDs.insert(lessonID)
        UserDefaults.standard.set(Array(completedLessonIDs), forKey: storageKey)
    }

    func completedCount(in module: TutorialModule) -> Int {
        TutorialCatalog.lessons(for: module).filter { isCompleted($0.id) }.count
    }

    var totalLessons: Int { TutorialCatalog.lessons.count }

    var completedLessons: Int { completedLessonIDs.count }

    var overallProgress: Double {
        guard totalLessons > 0 else { return 0 }
        return Double(completedLessons) / Double(totalLessons)
    }
}

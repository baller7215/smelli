//
//  TutorialModels.swift
//  smelli
//
//  Core types for the in-app Swift / SwiftUI tutorial.
//
//  ## Overview
//  Lessons are grouped into ``TutorialModule``s. Each ``TutorialLesson`` is built from
//  ``LessonSection`` blocks (text, code, playgrounds, quizzes). Content is defined in
//  ``TutorialCatalog``; this file only declares the shape of that content.
//
//  ## Documentation
//  - In-app guide: ``TutorialAboutView`` (toolbar on the tutorial home screen)
//  - Maintainer guide: `Tutorial/README.md` in the Xcode project
//
//  ## Adding a lesson
//  1. Append a ``TutorialLesson`` in `TutorialCatalog.swift` with a unique `id`.
//  2. Optionally add an ``InteractiveKind`` case and implement it in `TutorialPlaygrounds.swift`.
//  3. End the lesson with a ``Quiz`` so ``TutorialProgress`` can record completion.
//

import SwiftUI

/// Top-level curriculum unit shown on the tutorial home screen.
///
/// Each case maps to a section in the lesson list. Add a case here and matching
/// lessons in ``TutorialCatalog`` when introducing a new topic area.
enum TutorialModule: String, CaseIterable, Identifiable {
    case swiftBasics
    case swiftUI
    case state
    case navigation
    case iosApp

    var id: String { rawValue }

    var title: String {
        switch self {
        case .swiftBasics: "Swift Basics"
        case .swiftUI: "SwiftUI Views"
        case .state: "State & Binding"
        case .navigation: "Lists & Navigation"
        case .iosApp: "iOS App Structure"
        }
    }

    var icon: String {
        switch self {
        case .swiftBasics: "swift"
        case .swiftUI: "rectangle.3.group"
        case .state: "arrow.triangle.2.circlepath"
        case .navigation: "list.bullet"
        case .iosApp: "iphone"
        }
    }

    var tint: Color {
        switch self {
        case .swiftBasics: .orange
        case .swiftUI: .blue
        case .state: .purple
        case .navigation: .green
        case .iosApp: .pink
        }
    }
}

/// A single teachable unit: title, estimated time, and ordered content sections.
///
/// - Important: `id` must be stable and unique; it is persisted when a lesson is completed.
struct TutorialLesson: Identifiable, Hashable {
    let id: String
    let module: TutorialModule
    let title: String
    let subtitle: String
    let estimatedMinutes: Int
    let sections: [LessonSection]
}

/// One block of content inside a lesson, rendered by ``TutorialLessonView``.
enum LessonSection: Hashable {
    /// Section title (large type).
    case heading(String)
    /// Explanatory paragraph.
    case body(String)
    /// Monospaced Swift snippet; optional caption below the block.
    case code(String, caption: String? = nil)
    /// Yellow callout for best practices or warnings.
    case tip(String)
    /// Hands-on demo; see ``InteractiveKind`` and `TutorialPlaygrounds.swift`.
    case interactive(InteractiveKind)
    /// Multiple-choice checkpoint; correct answer marks the lesson complete.
    case quiz(Quiz)
}

/// Identifies which interactive demo to embed in an `.interactive(...)` section.
///
/// Add a case here, implement the view in `TutorialPlaygrounds.swift`, and reference
/// it from a lesson in ``TutorialCatalog``.
enum InteractiveKind: String, Hashable {
    case variablesPlayground
    case optionalsPlayground
    case controlFlowPlayground
    case viewBuilderPlayground
    case modifiersPlayground
    case statePlayground
    case bindingPlayground
    case listPlayground
    case navigationPlayground
    case appLifecyclePlayground
}

/// End-of-lesson checkpoint. `correctIndex` is zero-based into `choices`.
struct Quiz: Hashable {
    let question: String
    let choices: [String]
    let correctIndex: Int
    let explanation: String
}

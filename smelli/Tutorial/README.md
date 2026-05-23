# Swift & SwiftUI Interactive Tutorial

This folder contains an in-app tutorial for learning Swift, SwiftUI, and iOS app structure. It ships inside **smelli** and is the app’s root UI (`TutorialHomeView` in `smelliApp.swift`).

## For learners

1. Run the app in Xcode (⌘R) on Simulator or device.
2. Open a **module** (e.g. Swift Basics), then a **lesson**.
3. Read the content, use **Try it** playgrounds, and pass the **Checkpoint** quiz to mark the lesson complete.
4. Progress is stored locally on this device (`UserDefaults` key: `tutorial.completedLessonIDs`).

### Lesson building blocks

| Section type   | What you see                          |
|----------------|----------------------------------------|
| Heading / Body | Explanations                           |
| Code           | Copyable Swift snippets                |
| Tip            | Highlighted callouts                   |
| Interactive    | Live playground (toggles, counters, …) |
| Quiz           | Multiple-choice checkpoint             |

## For contributors (adding content)

### File map

```
Tutorial/
├── README.md                 ← this file
├── TutorialModels.swift      ← types: modules, lessons, sections, quizzes
├── TutorialCatalog.swift     ← all lesson copy and structure
├── TutorialProgress.swift    ← completion persistence
└── Views/
    ├── TutorialHomeView.swift       ← catalog & progress
    ├── TutorialLessonView.swift     ← renders a single lesson
    ├── TutorialComponents.swift     ← code blocks, quizzes, cards
    ├── TutorialPlaygrounds.swift    ← interactive demos
    └── TutorialAboutView.swift      ← in-app documentation
```

### Add a new lesson

1. Open `TutorialCatalog.swift` and append a `TutorialLesson` to the `lessons` array.
2. Use a **stable, unique** `id` (e.g. `"swift-enums"`).
3. Set `module` to an existing `TutorialModule` or add a new case in `TutorialModels.swift`.
4. Build `sections` from `LessonSection` cases (see below).

Example skeleton:

```swift
TutorialLesson(
    id: "swift-enums",
    module: .swiftBasics,
    title: "Enums",
    subtitle: "Named choices and switch safety",
    estimatedMinutes: 6,
    sections: [
        .heading("What is an enum?"),
        .body("…"),
        .code("enum Direction { case north, south }"),
        .interactive(.controlFlowPlayground),  // reuse or add new kind
        .quiz(Quiz(
            question: "…",
            choices: ["A", "B", "C", "D"],
            correctIndex: 0,
            explanation: "…"
        ))
    ]
)
```

### Add a new interactive playground

1. Add a case to `InteractiveKind` in `TutorialModels.swift`.
2. Implement a private view in `TutorialPlaygrounds.swift`.
3. Handle it in `InteractivePlaygroundView`’s `switch`.
4. Reference the kind from a lesson: `.interactive(.yourNewCase)`.

### Add a new module

1. Add a case to `TutorialModule` in `TutorialModels.swift` (`title`, `icon`, `tint`).
2. Add lessons with `module: .yourNewCase` in `TutorialCatalog.swift`.

### Section types (`LessonSection`)

- `.heading(String)` — section title
- `.body(String)` — paragraph text
- `.code(String, caption: String?)` — monospaced block; caption optional
- `.tip(String)` — yellow callout
- `.interactive(InteractiveKind)` — live demo
- `.quiz(Quiz)` — checkpoint; completing correctly marks the lesson done

### Progress API

`TutorialProgress.shared`:

- `markCompleted(_ lessonID:)` — called when a quiz is answered correctly
- `isCompleted(_:)` — drives checkmarks on the home list
- `overallProgress` — 0…1 for the home progress bar

## Architecture notes

- **Navigation**: `NavigationStack` + `navigationDestination(for: TutorialLesson.self)`.
- **State**: `@Observable` on `TutorialProgress`; injected via `.environment()` from the home view.
- **Xcode**: Files under `smelli/` are auto-included (filesystem-synchronized group).

## Related files outside this folder

- `smelli/smelliApp.swift` — app entry, shows `TutorialHomeView`
- `smelli/ContentView.swift` — separate sandbox view (not used as root by default)

//
//  TutorialCatalog.swift
//  smelli
//

import Foundation

enum TutorialCatalog {
    static let lessons: [TutorialLesson] = [
        // MARK: - Swift Basics
        TutorialLesson(
            id: "swift-variables",
            module: .swiftBasics,
            title: "Variables & Constants",
            subtitle: "Store and update data with `var` and `let`",
            estimatedMinutes: 5,
            sections: [
                .heading("Why Swift?"),
                .body("Swift is Apple's modern language for iOS, macOS, and more. It's safe, fast, and works seamlessly with SwiftUI for building user interfaces."),
                .heading("var vs let"),
                .body("`let` creates a constant — assign once, never change. `var` is mutable — you can update it later."),
                .code(
                    """
                    let appName = "smelli"      // constant
                    var tapCount = 0            // variable
                    tapCount += 1               // OK
                    // appName = "other"         // ❌ compile error
                    """,
                    caption: "Constants protect values that shouldn't change."
                ),
                .interactive(.variablesPlayground),
                .quiz(Quiz(
                    question: "Which keyword should you use for a value that never changes?",
                    choices: ["var", "let", "const", "static"],
                    correctIndex: 1,
                    explanation: "Use `let` for constants. Swift will refuse to compile if you try to reassign it."
                ))
            ]
        ),
        TutorialLesson(
            id: "swift-types",
            module: .swiftBasics,
            title: "Types & Strings",
            subtitle: "Numbers, Booleans, and string interpolation",
            estimatedMinutes: 5,
            sections: [
                .heading("Core types"),
                .body("Swift infers types when possible, but you can annotate them explicitly. Common types: `Int`, `Double`, `Bool`, and `String`."),
                .code(
                    """
                    let score: Int = 42
                    let pi = 3.14159          // Double (inferred)
                    let isOn = true           // Bool
                    let greeting = "Hello, \\(score)!"
                    """,
                    caption: "\\(expression) inside strings inserts values."
                ),
                .tip("Prefer type inference unless it makes code unclear."),
                .interactive(.variablesPlayground),
                .quiz(Quiz(
                    question: "How do you embed a variable inside a string?",
                    choices: ["\"Hello, %@\"", "\"Hello, \\(name)\"", "\"Hello, \" + name", "String.format(name)"],
                    correctIndex: 1,
                    explanation: "String interpolation uses \\(value) inside double quotes."
                ))
            ]
        ),
        TutorialLesson(
            id: "swift-optionals",
            module: .swiftBasics,
            title: "Optionals",
            subtitle: "Handle values that might be missing",
            estimatedMinutes: 7,
            sections: [
                .heading("The problem"),
                .body("Sometimes a value doesn't exist — no profile photo, no search result. Optionals express \"maybe nil\" safely so you can't crash by accident."),
                .code(
                    """
                    var nickname: String? = nil
                    nickname = "Leo"

                    if let name = nickname {
                        print("Hi, \\(name)")
                    }

                    let display = nickname ?? "Guest"
                    """,
                    caption: "Optional binding (`if let`) and nil-coalescing (`??`) are everyday tools."
                ),
                .interactive(.optionalsPlayground),
                .quiz(Quiz(
                    question: "What does `nickname ?? \"Guest\"` return when nickname is nil?",
                    choices: ["nil", "Guest", "nickname", "A crash"],
                    correctIndex: 1,
                    explanation: "The `??` operator returns the right-hand value when the left side is nil."
                ))
            ]
        ),
        TutorialLesson(
            id: "swift-control-flow",
            module: .swiftBasics,
            title: "Control Flow",
            subtitle: "if, switch, and loops",
            estimatedMinutes: 6,
            sections: [
                .heading("Decisions & repetition"),
                .body("Use `if` / `else` for branches, `switch` for many cases (no `break` needed), and `for` to iterate collections."),
                .code(
                    """
                    let level = 3
                    switch level {
                    case 1: print("Beginner")
                    case 2...5: print("Intermediate")
                    default: print("Expert")
                    }

                    for n in 1...3 { print(n) }
                    """,
                    caption: "Ranges like 2...5 are inclusive on both ends."
                ),
                .interactive(.controlFlowPlayground),
                .quiz(Quiz(
                    question: "In Swift, do you need `break` after each `switch` case?",
                    choices: ["Yes, always", "Only for strings", "No", "Only in SwiftUI"],
                    correctIndex: 2,
                    explanation: "Swift switches don't fall through — each case ends automatically."
                ))
            ]
        ),

        // MARK: - SwiftUI
        TutorialLesson(
            id: "swiftui-views",
            module: .swiftUI,
            title: "Views are values",
            subtitle: "Structs that describe UI",
            estimatedMinutes: 6,
            sections: [
                .heading("Declarative UI"),
                .body("SwiftUI views are structs conforming to `View`. You describe *what* the UI should look like; SwiftUI figures out *how* to draw and update it."),
                .code(
                    """
                    struct GreetingView: View {
                        var body: some View {
                            Text("Hello!")
                                .font(.title)
                        }
                    }
                    """,
                    caption: "`body` returns `some View` — one concrete view type."
                ),
                .interactive(.viewBuilderPlayground),
                .quiz(Quiz(
                    question: "What protocol must a SwiftUI screen conform to?",
                    choices: ["UIView", "View", "Observable", "AppDelegate"],
                    correctIndex: 1,
                    explanation: "Every SwiftUI component conforms to `View` and implements `body`."
                ))
            ]
        ),
        TutorialLesson(
            id: "swiftui-layout",
            module: .swiftUI,
            title: "Stacks & spacing",
            subtitle: "VStack, HStack, and layout",
            estimatedMinutes: 6,
            sections: [
                .heading("Compose with stacks"),
                .body("`VStack` arranges children vertically; `HStack` horizontally. Use `Spacer()` to push content apart and `.padding()` for breathing room."),
                .code(
                    """
                    VStack(spacing: 12) {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                    .padding()
                    """,
                    caption: "Stacks are the building blocks of most screens."
                ),
                .interactive(.viewBuilderPlayground),
                .quiz(Quiz(
                    question: "Which stack lays out children top to bottom?",
                    choices: ["HStack", "ZStack", "VStack", "List"],
                    correctIndex: 2,
                    explanation: "V = vertical. H = horizontal. Z = depth (overlapping)."
                ))
            ]
        ),
        TutorialLesson(
            id: "swiftui-modifiers",
            module: .swiftUI,
            title: "Modifiers",
            subtitle: "Chain styles and behavior",
            estimatedMinutes: 6,
            sections: [
                .heading("Order matters"),
                .body("Modifiers wrap a view and return a new view. They run in order — padding *then* background looks different than the reverse."),
                .code(
                    """
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    """,
                    caption: "Think of modifiers as layers applied outside-in."
                ),
                .interactive(.modifiersPlayground),
                .quiz(Quiz(
                    question: "Modifiers in SwiftUI…",
                    choices: [
                        "Mutate the original view in place",
                        "Return a new modified view",
                        "Only work on Text",
                        "Run only once at launch"
                    ],
                    correctIndex: 1,
                    explanation: "Views are value types; modifiers return transformed copies."
                ))
            ]
        ),

        // MARK: - State
        TutorialLesson(
            id: "state-property",
            module: .state,
            title: "@State",
            subtitle: "Local mutable UI state",
            estimatedMinutes: 7,
            sections: [
                .heading("When the UI must update"),
                .body("`@State` tells SwiftUI to store a value and redraw the view when it changes. Use it for simple state owned by *this* view (toggles, counters, text fields)."),
                .code(
                    """
                    struct CounterView: View {
                        @State private var count = 0

                        var body: some View {
                            Button("Count: \\(count)") {
                                count += 1
                            }
                        }
                    }
                    """,
                    caption: "Mark `@State` as `private` — it's internal to the view."
                ),
                .interactive(.statePlayground),
                .quiz(Quiz(
                    question: "When `count` changes in a `@State` property, SwiftUI…",
                    choices: [
                        "Ignores it",
                        "Re-renders the view",
                        "Restarts the app",
                        "Requires manual refresh"
                    ],
                    correctIndex: 1,
                    explanation: "SwiftUI tracks `@State` and schedules view updates automatically."
                ))
            ]
        ),
        TutorialLesson(
            id: "binding",
            module: .state,
            title: "@Binding",
            subtitle: "Share state with child views",
            estimatedMinutes: 7,
            sections: [
                .heading("Two-way connection"),
                .body("A child that needs to read *and* write a parent's `@State` receives a `@Binding` — a reference, not a copy."),
                .code(
                    """
                    struct ParentView: View {
                        @State private var isOn = false
                        var body: some View {
                            ToggleRow(isOn: $isOn)
                        }
                    }

                    struct ToggleRow: View {
                        @Binding var isOn: Bool
                        var body: some View {
                            Toggle("Enabled", isOn: $isOn)
                        }
                    }
                    """,
                    caption: "The `$` prefix creates a binding from `@State`."
                ),
                .interactive(.bindingPlayground),
                .quiz(Quiz(
                    question: "How do you pass a binding to a child?",
                    choices: ["isOn: isOn", "isOn: $isOn", "@Binding isOn", "Binding(isOn)"],
                    correctIndex: 1,
                    explanation: "Use `$propertyName` to pass a `Binding` from `@State`."
                ))
            ]
        ),

        // MARK: - Navigation
        TutorialLesson(
            id: "lists",
            module: .navigation,
            title: "Lists",
            subtitle: "Scrollable rows from data",
            estimatedMinutes: 6,
            sections: [
                .heading("ForEach + List"),
                .body("`List` efficiently displays rows. Pair it with `ForEach` over identifiable data to build settings screens, feeds, and more."),
                .code(
                    """
                    let fruits = ["Apple", "Banana", "Cherry"]

                    List(fruits, id: \\.self) { fruit in
                        Text(fruit)
                    }
                    """,
                    caption: "Models should conform to `Identifiable` when possible."
                ),
                .interactive(.listPlayground),
                .quiz(Quiz(
                    question: "Why does `ForEach` need `id:` or `Identifiable`?",
                    choices: [
                        "For sorting only",
                        "So SwiftUI can track row identity across updates",
                        "For networking",
                        "It's optional and unused"
                    ],
                    correctIndex: 1,
                    explanation: "Stable IDs let SwiftUI animate insertions and deletions correctly."
                ))
            ]
        ),
        TutorialLesson(
            id: "navigation-stack",
            module: .navigation,
            title: "NavigationStack",
            subtitle: "Push and pop screens",
            estimatedMinutes: 7,
            sections: [
                .heading("Hierarchical navigation"),
                .body("`NavigationStack` manages a stack of screens. `NavigationLink` pushes; the back button pops. This tutorial app uses exactly that pattern."),
                .code(
                    """
                    NavigationStack {
                        List(items) { item in
                            NavigationLink(item.name) {
                                DetailView(item: item)
                            }
                        }
                        .navigationTitle("Items")
                    }
                    """,
                    caption: "You're inside a NavigationStack right now."
                ),
                .interactive(.navigationPlayground),
                .quiz(Quiz(
                    question: "What pushes a new screen onto the stack?",
                    choices: ["TabView", "Sheet", "NavigationLink", "Alert"],
                    correctIndex: 2,
                    explanation: "NavigationLink (or programmatic path) drives stack navigation."
                ))
            ]
        ),

        // MARK: - iOS App
        TutorialLesson(
            id: "app-entry",
            module: .iosApp,
            title: "App entry point",
            subtitle: "@main, App, and WindowGroup",
            estimatedMinutes: 6,
            sections: [
                .heading("Where execution starts"),
                .body("The `@main` attribute marks your app's entry. SwiftUI apps use the `App` protocol and declare scenes — usually a `WindowGroup` with your root view."),
                .code(
                    """
                    @main
                    struct smelliApp: App {
                        var body: some Scene {
                            WindowGroup {
                                TutorialHomeView()
                            }
                        }
                    }
                    """,
                    caption: "Open smelliApp.swift in Xcode to see your real entry point."
                ),
                .interactive(.appLifecyclePlayground),
                .quiz(Quiz(
                    question: "What does `WindowGroup` provide?",
                    choices: [
                        "A database",
                        "A window / scene for your SwiftUI views",
                        "Push notifications",
                        "Unit tests"
                    ],
                    correctIndex: 1,
                    explanation: "Scenes represent windows on iOS, iPadOS, and macOS."
                ))
            ]
        ),
        TutorialLesson(
            id: "previews",
            module: .iosApp,
            title: "Previews & Xcode",
            subtitle: "Iterate without running on device",
            estimatedMinutes: 5,
            sections: [
                .heading("Fast feedback"),
                .body("Add `#Preview` at the bottom of a view file to see live UI in Xcode's canvas. Change code — the preview updates. Run on Simulator when you need full app behavior."),
                .code(
                    """
                    #Preview {
                        ContentView()
                    }
                    """,
                    caption: "Press ⌥⌘↩ in Xcode to refresh previews."
                ),
                .tip("Keep previews small — one view with mock data is ideal."),
                .interactive(.appLifecyclePlayground),
                .quiz(Quiz(
                    question: "Previews are best for…",
                    choices: [
                        "App Store submission",
                        "Rapid UI iteration in Xcode",
                        "Production networking",
                        "Keychain access"
                    ],
                    correctIndex: 1,
                    explanation: "Previews speed up UI work; always test on Simulator/device too."
                ))
            ]
        )
    ]

    static func lessons(for module: TutorialModule) -> [TutorialLesson] {
        lessons.filter { $0.module == module }
    }

    static func lesson(id: String) -> TutorialLesson? {
        lessons.first { $0.id == id }
    }
}

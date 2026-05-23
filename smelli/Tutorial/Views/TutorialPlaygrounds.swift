//
//  TutorialPlaygrounds.swift
//  smelli
//

import SwiftUI

struct InteractivePlaygroundView: View {
    let kind: InteractiveKind

    var body: some View {
        switch kind {
        case .variablesPlayground:
            VariablesPlayground()
        case .optionalsPlayground:
            OptionalsPlayground()
        case .controlFlowPlayground:
            ControlFlowPlayground()
        case .viewBuilderPlayground:
            ViewBuilderPlayground()
        case .modifiersPlayground:
            ModifiersPlayground()
        case .statePlayground:
            StatePlayground()
        case .bindingPlayground:
            BindingPlayground()
        case .listPlayground:
            ListPlayground()
        case .navigationPlayground:
            NavigationPlayground()
        case .appLifecyclePlayground:
            AppLifecyclePlayground()
        }
    }
}

// MARK: - Swift Basics

private struct VariablesPlayground: View {
    @State private var useConstant = true
    @State private var tapCount = 0

    var body: some View {
        PlaygroundCard(title: "Try it") {
            Picker("Storage", selection: $useConstant) {
                Text("let (constant)").tag(true)
                Text("var (variable)").tag(false)
            }
            .pickerStyle(.segmented)

            Text("appName = \"smelli\"")
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.quaternarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 6))

            Button("tapCount += 1") {
                if useConstant {
                    // Simulated: constants can't change
                } else {
                    tapCount += 1
                }
            }
            .buttonStyle(.borderedProminent)

            Text(statusMessage)
                .font(.subheadline)
                .foregroundStyle(useConstant ? .orange : .primary)
        }
    }

    private var statusMessage: String {
        if useConstant {
            return "With `let`, tapCount can't change — tap does nothing."
        }
        return "tapCount is now \(tapCount) (var allows updates)."
    }
}

private struct OptionalsPlayground: View {
    @State private var hasNickname = false
    @State private var nickname = "Leo"

    private var resolvedNickname: String? {
        guard hasNickname else { return nil }
        let trimmed = nickname.trimmingCharacters(in: .whitespaces)
        return trimmed.isEmpty ? nil : trimmed
    }

    var body: some View {
        PlaygroundCard(title: "Try it") {
            Toggle("Has nickname?", isOn: $hasNickname)
            if hasNickname {
                TextField("Nickname", text: $nickname)
                    .textFieldStyle(.roundedBorder)
            }
            Divider()
            if let name = resolvedNickname {
                Text("if let → Hi, \(name)!")
                    .font(.subheadline)
            } else {
                Text("if let → (skipped — nil)")
                    .font(.subheadline)
            }
            Text("?? fallback → \(resolvedNickname ?? "Guest")")
                .font(.subheadline.weight(.medium))
        }
    }
}

private struct ControlFlowPlayground: View {
    @State private var level = 3

    var body: some View {
        PlaygroundCard(title: "Try it") {
            Stepper("Level: \(level)", value: $level, in: 1...6)
            Text("switch result: \(levelLabel)")
                .font(.subheadline.weight(.semibold))
            Text("for loop: \(loopOutput)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var levelLabel: String {
        switch level {
        case 1: return "Beginner"
        case 2...5: return "Intermediate"
        default: return "Expert"
        }
    }

    private var loopOutput: String {
        (1...min(level, 4)).map(String.init).joined(separator: ", ")
    }
}

// MARK: - SwiftUI

private struct ViewBuilderPlayground: View {
    @State private var layout = 0

    var body: some View {
        PlaygroundCard(title: "Try it") {
            Picker("Layout", selection: $layout) {
                Text("VStack").tag(0)
                Text("HStack").tag(1)
            }
            .pickerStyle(.segmented)

            Group {
                if layout == 0 {
                    VStack(spacing: 8) {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                        Text("Featured")
                    }
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                        Text("Featured")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

private struct ModifiersPlayground: View {
    @State private var paddingFirst = true

    var body: some View {
        PlaygroundCard(title: "Try it") {
            Toggle("Padding before background", isOn: $paddingFirst)
            Group {
                if paddingFirst {
                    sampleText
                        .padding()
                        .background(Color.blue.opacity(0.3))
                } else {
                    sampleText
                        .background(Color.blue.opacity(0.3))
                        .padding()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(paddingFirst ? "Blue hugs the text (inset)." : "Blue fills extra space (outset).")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var sampleText: some View {
        Text("Save")
            .font(.headline)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - State

private struct StatePlayground: View {
    @State private var count = 0

    var body: some View {
        PlaygroundCard(title: "Try it") {
            Text("\(count)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
            HStack {
                Button("−") { count -= 1 }
                Button("Reset") { count = 0 }
                Button("+") { count += 1 }
            }
            .buttonStyle(.bordered)
            Text("@State triggers a re-render when count changes.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct BindingPlayground: View {
    @State private var isOn = false

    var body: some View {
        PlaygroundCard(title: "Try it") {
            ToggleRow(isOn: $isOn)
            Text("Parent sees: \(isOn ? "ON" : "OFF")")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct ToggleRow: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle("Child toggle (@Binding)", isOn: $isOn)
    }
}

// MARK: - Navigation

private struct ListPlayground: View {
    @State private var fruits = ["Apple", "Banana", "Cherry"]
    @State private var newFruit = ""

    var body: some View {
        PlaygroundCard(title: "Try it") {
            List {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
                .onDelete { offsets in
                    fruits.remove(atOffsets: offsets)
                }
            }
            .frame(height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            HStack {
                TextField("New fruit", text: $newFruit)
                    .textFieldStyle(.roundedBorder)
                Button("Add") {
                    let trimmed = newFruit.trimmingCharacters(in: .whitespaces)
                    guard !trimmed.isEmpty else { return }
                    fruits.append(trimmed)
                    newFruit = ""
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

private struct NavigationPlayground: View {
    var body: some View {
        PlaygroundCard(title: "Try it") {
            NavigationStack {
                List(["Lesson A", "Lesson B"], id: \.self) { item in
                    NavigationLink(item) {
                        Text("Detail for \(item)")
                            .navigationTitle(item)
                    }
                }
                .navigationTitle("Mini stack")
            }
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

// MARK: - iOS App

private struct AppLifecyclePlayground: View {
    @State private var phase = "Launch"

    var body: some View {
        PlaygroundCard(title: "Simulate lifecycle") {
            HStack {
                ForEach(["Launch", "Active", "Background"], id: \.self) { step in
                    Button(step) { phase = step }
                        .buttonStyle(.bordered)
                        .tint(phase == step ? .accentColor : .secondary)
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                lifecycleRow("@main smelliApp", detail: "App starts")
                lifecycleRow("WindowGroup", detail: "Scene created")
                lifecycleRow("TutorialHomeView", detail: "Root UI shown — phase: \(phase)")
            }
            .font(.caption)
        }
    }

    private func lifecycleRow(_ title: String, detail: String) -> some View {
        HStack(alignment: .top) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .padding(.top, 5)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).fontWeight(.medium)
                Text(detail).foregroundStyle(.secondary)
            }
        }
    }
}

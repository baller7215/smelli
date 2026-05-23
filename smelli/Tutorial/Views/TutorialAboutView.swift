//
//  TutorialAboutView.swift
//  smelli
//

import SwiftUI

struct TutorialAboutView: View {
    var body: some View {
        List {
            Section("How to use") {
                Label("Pick a module and lesson from the home screen.", systemImage: "list.bullet")
                Label("Read explanations and copy code samples.", systemImage: "doc.text")
                Label("Use Try it playgrounds to experiment.", systemImage: "hand.tap")
                Label("Pass the checkpoint quiz to complete a lesson.", systemImage: "checkmark.circle")
            }

            Section("What's covered") {
                ForEach(TutorialModule.allCases) { module in
                    HStack {
                        Label(module.title, systemImage: module.icon)
                            .foregroundStyle(module.tint)
                        Spacer()
                        Text("\(TutorialCatalog.lessons(for: module).count) lessons")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section("Lesson parts") {
                docRow("Heading / Body", "Explanations and concepts")
                docRow("Code", "Copyable Swift snippets")
                docRow("Tip", "Highlighted notes")
                docRow("Try it", "Interactive playgrounds")
                docRow("Checkpoint", "Quiz to mark completion")
            }

            Section("Progress") {
                Text("Completed lessons are saved on this device. Reset by deleting and reinstalling the app, or clear the `tutorial.completedLessonIDs` key in UserDefaults during development.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Section("Extending the tutorial") {
                Text("Lesson content lives in TutorialCatalog.swift. Types are in TutorialModels.swift; playgrounds in TutorialPlaygrounds.swift.")
                    .font(.subheadline)
                Text("See Tutorial/README.md in the project for a full contributor guide.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Section {
                LabeledContent("Lessons", value: "\(TutorialCatalog.lessons.count)")
                LabeledContent("Modules", value: "\(TutorialModule.allCases.count)")
            }
        }
        .navigationTitle("About the Tutorial")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func docRow(_ title: String, _ detail: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.subheadline.weight(.medium))
            Text(detail).font(.caption).foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    NavigationStack {
        TutorialAboutView()
    }
}

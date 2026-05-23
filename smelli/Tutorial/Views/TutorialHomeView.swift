//
//  TutorialHomeView.swift
//  smelli
//

import SwiftUI

struct TutorialHomeView: View {
    @State private var progress = TutorialProgress.shared

    var body: some View {
        NavigationStack {
            List {
                overviewSection
                ForEach(TutorialModule.allCases) { module in
                    moduleSection(module)
                }
            }
            .navigationTitle("Swift & SwiftUI")
            .listStyle(.insetGrouped)
            .navigationDestination(for: TutorialLesson.self) { lesson in
                TutorialLessonView(lesson: lesson)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        TutorialAboutView()
                    } label: {
                        Label("About", systemImage: "book.closed")
                    }
                }
            }
        }
        .environment(progress)
    }

    private var overviewSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 12) {
                Text("Learn by doing")
                    .font(.title2.weight(.bold))
                Text("Tap any lesson for explanations, copyable code, live playgrounds, and checkpoints. Progress is saved on this device.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                ProgressView(value: progress.overallProgress) {
                    Text("\(progress.completedLessons) of \(progress.totalLessons) lessons")
                        .font(.caption)
                }
            }
            .padding(.vertical, 4)
        }
    }

    private func moduleSection(_ module: TutorialModule) -> some View {
        let moduleLessons = TutorialCatalog.lessons(for: module)
        let completed = progress.completedCount(in: module)
        let fraction = moduleLessons.isEmpty ? 0 : Double(completed) / Double(moduleLessons.count)

        return Section {
            ForEach(moduleLessons) { lesson in
                NavigationLink(value: lesson) {
                    LessonRow(lesson: lesson, isCompleted: progress.isCompleted(lesson.id))
                }
            }
        } header: {
            HStack {
                Label(module.title, systemImage: module.icon)
                    .foregroundStyle(module.tint)
                Spacer()
                ModuleProgressRing(progress: fraction, tint: module.tint)
            }
        } footer: {
            if completed == moduleLessons.count, !moduleLessons.isEmpty {
                Text("Module complete")
            }
        }
    }
}

private struct LessonRow: View {
    let lesson: TutorialLesson
    let isCompleted: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(lesson.title)
                    .font(.body.weight(.medium))
                Text(lesson.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer()
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    TutorialHomeView()
}

//
//  TutorialLessonView.swift
//  smelli
//

import SwiftUI

struct TutorialLessonView: View {
    let lesson: TutorialLesson
    @Environment(TutorialProgress.self) private var progress
    @State private var quizPassed = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                ForEach(Array(lesson.sections.enumerated()), id: \.offset) { _, section in
                    sectionView(section)
                }
                if quizPassed || progress.isCompleted(lesson.id) {
                    completionBanner
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            quizPassed = progress.isCompleted(lesson.id)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(lesson.module.title, systemImage: lesson.module.icon)
                .font(.caption.weight(.semibold))
                .foregroundStyle(lesson.module.tint)
            Text(lesson.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Label("\(lesson.estimatedMinutes) min", systemImage: "clock")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private func sectionView(_ section: LessonSection) -> some View {
        switch section {
        case .heading(let text):
            Text(text)
                .font(.title3.weight(.semibold))
                .padding(.top, 4)
        case .body(let text):
            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        case .code(let code, let caption):
            CodeBlockView(code: code, caption: caption)
        case .tip(let text):
            TipCardView(text: text)
        case .interactive(let kind):
            InteractivePlaygroundView(kind: kind)
        case .quiz(let quiz):
            QuizView(quiz: quiz) {
                quizPassed = true
                progress.markCompleted(lesson.id)
            }
        }
    }

    private var completionBanner: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundStyle(.green)
            Text("Lesson complete — nice work!")
                .font(.subheadline.weight(.medium))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.green.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

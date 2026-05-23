//
//  TutorialComponents.swift
//  smelli
//

import SwiftUI

struct CodeBlockView: View {
    let code: String
    var caption: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))

            if let caption {
                Text(caption)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct TipCardView: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .foregroundStyle(.yellow)
            Text(text)
                .font(.subheadline)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct PlaygroundCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: "hand.tap.fill")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.accentColor.opacity(0.25), lineWidth: 1)
        )
    }
}

struct QuizView: View {
    let quiz: Quiz
    var onAnsweredCorrectly: () -> Void

    @State private var selectedIndex: Int?
    @State private var hasSubmitted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Checkpoint")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            Text(quiz.question)
                .font(.headline)

            ForEach(quiz.choices.indices, id: \.self) { index in
                Button {
                    guard !hasSubmitted else { return }
                    selectedIndex = index
                    hasSubmitted = true
                    if index == quiz.correctIndex {
                        onAnsweredCorrectly()
                    }
                } label: {
                    HStack {
                        Text(quiz.choices[index])
                            .multilineTextAlignment(.leading)
                        Spacer()
                        if hasSubmitted {
                            if index == quiz.correctIndex {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else if index == selectedIndex {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .padding(12)
                    .background(choiceBackground(for: index))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(hasSubmitted && selectedIndex != index && index != quiz.correctIndex)
            }

            if hasSubmitted {
                Text(quiz.explanation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func choiceBackground(for index: Int) -> Color {
        guard hasSubmitted, let selectedIndex else {
            return Color(.tertiarySystemGroupedBackground)
        }
        if index == quiz.correctIndex {
            return Color.green.opacity(0.15)
        }
        if index == selectedIndex {
            return Color.red.opacity(0.15)
        }
        return Color(.tertiarySystemGroupedBackground)
    }
}

struct ModuleProgressRing: View {
    let progress: Double
    let tint: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(tint.opacity(0.2), lineWidth: 4)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .frame(width: 36, height: 36)
    }
}

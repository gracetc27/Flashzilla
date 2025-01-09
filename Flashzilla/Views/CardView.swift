//
//  CardView.swift
//  Flashzilla
//
//  Created by Grace couch on 03/12/2024.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var showingAnswer = false
    @State private var dragOffset = CGSize.zero
    var card: Card
    var removal: (() -> Void)
    var reinsert: (() -> Void)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(dragOffset.width / 50))))
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fillCard(offset: dragOffset.width)
                )
                .shadow(radius: 12)
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(showingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.black)
                    if showingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(dragOffset.width / 5.0))
        .offset(x: dragOffset.width * 5.0)
        .opacity(2 - Double(abs(dragOffset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    dragOffset = gesture.translation
                }
                .onEnded { _ in
                    if dragOffset.width > 100 {
                        removal()
                    } else if dragOffset.width < -100 {
                        reinsert()
                        dragOffset = .zero
                    } else {
                        dragOffset = .zero
                    }
                }
        )
        .onTapGesture {
            withAnimation {
                showingAnswer.toggle()
            }
        }
        .animation(.default, value: dragOffset)
    }
}


#Preview {
    CardView(card: .example) { } reinsert:{ }
}

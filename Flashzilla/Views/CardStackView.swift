//
//  CardStackView.swift
//  Flashzilla
//
//  Created by Grace couch on 03/12/2024.
//

import SwiftUI

struct CardStackView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @State private var viewModel = CardStackViewModel()


    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time Remaining: \(viewModel.timeRemaining)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.7))
                    .clipShape(.capsule)
                ZStack {
                    ForEach(viewModel.cards) { card in
                        let index = viewModel.getIndex(of: card)
                        CardView(card: card) {
                            withAnimation {
                                viewModel.removeCard(at: index)
                            }
                        } reinsert: {
                            viewModel.cards.move(at: index, to: 0)
                        }
                        .stacked(at: index, in: viewModel.cards.count)
                        .allowsHitTesting(index == viewModel.cards.count - 1)
                        .accessibilityHidden(index < viewModel.cards.count - 1)
                    }
                }
                .allowsHitTesting(viewModel.timeRemaining > 0)

                if viewModel.cards.isEmpty {
                    Button("Start again", action: viewModel.resetCards)
                        .padding()
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(.capsule)
                }
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        viewModel.showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                viewModel.removeCard(at: viewModel.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark answer as wrong")
                        Spacer()
                        Button {
                            withAnimation {
                                viewModel.removeCard(at: viewModel.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark answer as correct")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        
        .onReceive(viewModel.timer) { time in
            guard viewModel.isActive else { return }
            if viewModel.timeRemaining > 0 {
                viewModel.timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if viewModel.cards.isEmpty == false {
                    viewModel.isActive = true
                }
            } else {
                viewModel.isActive = false
            }
        }
        .sheet(isPresented: $viewModel.showingEditScreen, onDismiss: viewModel.resetCards, content: EditCardsView.init)
        .onAppear(perform: viewModel.resetCards)
    }
}

#Preview {
    CardStackView()
}

extension Array {
    mutating func move(at index: Index, to: Index) {
        let item = remove(at: index)
        insert(item, at: to)
    }
}

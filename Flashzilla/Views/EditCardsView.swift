//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Grace couch on 07/01/2025.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss

    @State private var viewModel = EditCardsViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section("Add new flashcard") {
                    TextField("New Prompt", text: $viewModel.newPrompt)
                    TextField("New Answer", text: $viewModel.newAnswer)
                    Button("Add Card", action: viewModel.addCard)
                }

                Section("Existing Cards") {
                    ForEach(viewModel.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: viewModel.removeCards)
                }
            }
            .navigationTitle("Edit Flashcards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: viewModel.loadData)
        }
    }

    func done() {
        dismiss()
    }
}

#Preview {
    EditCardsView()
}

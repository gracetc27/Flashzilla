//
//  EditCardsViewModel.swift
//  Flashzilla
//
//  Created by Grace couch on 09/01/2025.
//
import SwiftUI

@Observable
class EditCardsViewModel {
    var cards = [Card]()
    var newPrompt = ""
    var newAnswer = ""

    let savePath = URL.documentsDirectory.appending(path: "SavedCards")

    func saveCards() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }

    func loadCards() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print(error.localizedDescription)
            cards = []
        }
    }

    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        let id = UUID()
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let card = Card(id: id, prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveCards()
        newAnswer = ""
        newPrompt = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveCards()
    }

}

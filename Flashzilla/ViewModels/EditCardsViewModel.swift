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

    func saveCard() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "cards")
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }

    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        let id = UUID()
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let card = Card(id: id, prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveCard()
        newAnswer = ""
        newPrompt = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveCard()
    }

}

//
//  CardStackViewModel.swift
//  Flashzilla
//
//  Created by Grace couch on 09/01/2025.
//
import SwiftUI

@Observable
class CardStackViewModel {
    var isActive = true
    var cards = [Card]()
    var showingEditScreen = false
    var timeRemaining = 100
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func getIndex(of card: Card) -> Int {
        return cards.firstIndex { $0.id == card.id }!
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }

    func resetCards() {
        timeRemaining = 100
        loadData()
        isActive = !cards.isEmpty
    }

    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)

        if cards.isEmpty {
            isActive = false
        }
    }

}

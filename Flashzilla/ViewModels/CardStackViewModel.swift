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


    let savePath = URL.documentsDirectory.appending(path: "SavedCards")



    func loadCards() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print(error.localizedDescription)
            cards = []
        }
    }


    func getIndex(of card: Card) -> Int {
        return cards.firstIndex { $0.id == card.id }!
    }

    func resetCards() {
        timeRemaining = 100
        loadCards()
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

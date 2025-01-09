//
//  Card.swift
//  Flashzilla
//
//  Created by Grace couch on 03/12/2024.
//
import SwiftUI

struct Card: Codable, Identifiable {
    let id: UUID
    var prompt: String
    var answer: String

    static let example = Card(id: UUID() ,prompt: "What is 'Thanks' in norwegian?", answer: "Takk")
}

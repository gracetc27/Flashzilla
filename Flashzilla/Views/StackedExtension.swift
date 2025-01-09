//
//  StackedExtension.swift
//  Flashzilla
//
//  Created by Grace couch on 09/01/2025.
//
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 4, y: offset * 10)
    }
}

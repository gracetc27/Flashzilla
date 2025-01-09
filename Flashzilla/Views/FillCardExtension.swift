//
//  FillCardExtension.swift
//  Flashzilla
//
//  Created by Grace couch on 09/01/2025.
//
import SwiftUI

extension View {
    func fillCard(offset: CGFloat) -> some View {
        if offset > 0 {
            return self.foregroundStyle(.green)
        } else if offset < 0 {
            return self.foregroundStyle(.red)
        } else {
            return self.foregroundStyle(.white)
        }
    }
}

//
//  Card.swift
//  Сoncentration
//
//  Created by Aleksandra on 20.08.2021.
//

import Foundation

struct Card: Hashable {
    
    func hush(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    static var identifierNumber = 0
    static func identifierGeneration() -> Int{
        identifierNumber += 1
        return identifierNumber
    }
    init() {
        self.identifier = Card.identifierGeneration()
    }
}

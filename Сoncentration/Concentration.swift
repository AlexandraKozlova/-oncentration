//
//  Concentration.swift
//  Сoncentration
//
//  Created by Aleksandra on 20.08.2021.
//

import Foundation

struct Concentation {
    
    private(set) var cards = [Card] ()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
        }
    }
    }
   
    mutating func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
               indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init(numberOfPairOfCards: Int){
        assert(numberOfPairOfCards > 0, "Concentration.init (/numberOfPairOfCards): must have at list one pair of cards" )
        for _ in 1...numberOfPairOfCards{
            let card = Card()
            cards += [card,card]
            cards.shuffle()
        }
    }
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

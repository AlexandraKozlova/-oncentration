//
//  ViewController.swift
//  Сoncentration
//
//  Created by Aleksandra on 19.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
   private lazy var game = Concentation(numberOfPairOfCards: numberOfPairOfCards)
   var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
   
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributed: [ NSAttributedString.Key:Any ] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.red]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributed)
        flip.attributedText = attributedString
    }

    private var emoji = "🛼🐷👙🌸🍉🎸🛍🎈🌈"
    private var emojiDictionary = [Card:String]()
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStringIndex = emoji.index(emoji.startIndex, offsetBy: emoji.count.arc4randomExtension)
            emojiDictionary[card] = String(emoji.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.3086819947, blue: 0.3321568668, alpha: 1)
            }
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flip: UILabel! {
        didSet {
        updateFlipCountLabel()
    }
}
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if  let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.3086819947, blue: 0.3321568668, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}


extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}



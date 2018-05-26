//
//  ViewController.swift
//  StanfordCourse
//
//  Created by Sarah Gamal on 5/19/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1 ) / 2 )
    
    var flipCount = 0 { didSet { flipCountLabel.text = ("flips : \(flipCount)") } }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
     }
    
    
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor =  card.isMatched ?  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0) : #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }
            pointsLabel.text = "Points: \(game.points)"
        }
    }
    
    
    
    var themes = [
        ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"],
        ["👩🏼‍💼","💓","🍆","🤲","❤️","💜","💑"],
        ["🏈","⚾️","🎾","🎱","⚽️","🏋🏿‍♂️","⛳️","🎿","🏹","🏀"],
        ["✝️","🕉","☮️","💟","🕎","☸️","☦️"],
        ["🐝","🦑","🕷","🐢","🐡","🐊","🐠"],
        ["🇧🇿","🇦🇸","🇦🇽","🇱🇷","🇻🇮","🇵🇲","🇬🇸","🇮🇲","🇨🇰"]
    ]
    var emojiChoices = ["🐔","👻","🎃" ,"🦄" ,"🏀","😀","😢","😉","🏀"]
    var emoji = [Int:String]()
 
    func emoji(for card: Card) -> String {
       if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    // New Button
    
    @IBAction func NewGame(_ sender: Any) {
        game = newConcentration()
        updateViewFromModel()
        emojiChoices = newEmojiChoices()
    }
    
    func newEmojiChoices () -> [String]{
        return themes[Int(arc4random_uniform(UInt32(themes.count)))]
    }
    func newConcentration () -> Concentration {
        return Concentration(numberOfPairsOfCards: (cardButtons.count + 1 ) / 2)
    }
    
}


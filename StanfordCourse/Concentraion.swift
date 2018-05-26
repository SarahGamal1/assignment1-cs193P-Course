//
//  Concentraion.swift
//  StanfordCourse
//
//  Created by Sarah Gamal on 5/23/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class Concentration {
    
    var points = 0
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index : Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard , matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    points += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
   
    init (numberOfPairsOfCards : Int) {
        
        for _ in 1...numberOfPairsOfCards {
            
            let card = Card()
            cards += [ card , card ]
        }
        
        // TODO : Shuffle the cards 
    }
}

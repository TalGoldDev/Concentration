//
//  Concentration.swift
//  Concentration
//
//  Created by Tal on 22/10/2018.
//  Copyright © 2018 Tal. All rights reserved.
//

import Foundation

class Concentration{
    
    var isGameComplete = false
    var cards = [Card]()
    var score = 0
        
    var currentFaceUpCard : Int?

    func chooseCard(at index: Int){
        if !cards[index].isMatched {
      
            if let matchIndex = currentFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                    checkIfGameComplete()
                }
                currentFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    if cards[flipDownIndex].isFacedUp {
                        if !cards[flipDownIndex].isMatched && cards[flipDownIndex].hasBeenFlippedAtLeastOnce {
                            score -= 1
                        }
                        cards[flipDownIndex].hasBeenFlippedAtLeastOnce = true
                        cards[flipDownIndex].isFacedUp = false;
                    }
                }
                currentFaceUpCard = index
            }
            cards[index].isFacedUp = true
        }
    }
    
    init(numberOfSets: Int) {
        for _ in 0..<numberOfSets {
            let card = Card()
            cards += [card, card]
        }
        
        for k in stride(from: cards.count - 1, to: 0, by: -1) {
            cards.swapAt(Int(arc4random_uniform(UInt32(k + 1))), k)
        }
    }
    
    
    func checkIfGameComplete() {
        for card in cards {
            if !card.isMatched {
                isGameComplete = false
                return
            }
        }
        isGameComplete = true
    }
        
}

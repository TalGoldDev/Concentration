//
//  Card.swift
//  Concentration
//
//  Created by Tal on 22/10/2018.
//  Copyright © 2018 Tal. All rights reserved.
//

import Foundation

struct Card {
    var isFacedUp = false
    var isMatched = false
    var hasBeenFlippedAtLeastOnce = false
    let identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

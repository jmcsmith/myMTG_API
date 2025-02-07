//
//  Updates.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 2/7/25.
//

import Foundation
import Vapor

final class Updates: Content, @unchecked Sendable {
    var updateCards: [UpdateCard]
    var updateTokens: [UpdateToken]
    var updateSets: [UpdateSet]
    
    init(updateCards: [UpdateCard], updateTokens: [UpdateToken], updateSets: [UpdateSet]) {
        self.updateCards = updateCards
        self.updateTokens = updateTokens
        self.updateSets = updateSets
    }
    
}

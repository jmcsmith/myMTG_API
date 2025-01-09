//
//  UpdateDTO.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/7/25.
//

import Fluent
import Vapor

struct UpdateDTO: Content {
    var newSetCodes: [String] = []
    var updatedCards: [UpdateCardDTO] = []
    var updatedTokens: [UpdateTokenDTO] = []
    var updateDate: Date
}

struct UpdateCardDTO: Content {
    var cardUUID: String
    var cardJSON: String
}
struct UpdateTokenDTO: Content {
    var tokenUUID: String
    var tokenJSON: String
}

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
    var updateDate: Date
}

struct UpdateCardDTO: Content {
    var cardUUID: String
    var cardJSON: String
}

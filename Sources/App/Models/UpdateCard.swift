//
//  UpdateCard.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/7/25.
//

import Fluent
import Foundation

final class UpdateCard: Model, @unchecked Sendable {
    static let schema = "updatecard"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "cardUUID")
    var cardUUID: String
    
    @Field(key: "cardJSON")
    var cardJSON: String
    
    @Field(key: "cardSetCode")
    var cardSetCode: String
    
    @Field(key: "updateDate")
    var updateDate: Date
    
    init() { }

    init(id: UUID? = nil, cardUUID: String, cardJSON: String, cardSetCode: String, updateDate: Date) {
        self.id = id
        self.cardUUID = cardUUID
        self.cardJSON = cardJSON
        self.cardSetCode = cardSetCode
        self.updateDate = updateDate
    }
}

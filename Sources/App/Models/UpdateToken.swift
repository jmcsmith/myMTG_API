//
//  UpdateToken.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/8/25.
//

import Fluent
import Foundation

final class UpdateToken: Model, @unchecked Sendable {
    static let schema = "updatetoken"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "tokenUUID")
    var tokenUUID: String
    
    @Field(key: "tokenJSON")
    var tokenJSON: String
    
    @Field(key: "updateDate")
    var updateDate: Date
    
    init() { }

    init(id: UUID? = nil, tokenUUID: String, tokenJSON: String, updateDate: Date) {
        self.id = id
        self.tokenUUID = tokenUUID
        self.tokenJSON = tokenJSON
        self.updateDate = updateDate
    }
}

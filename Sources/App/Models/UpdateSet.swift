//
//  UpdateSet.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/7/25.
//

import Fluent
import Foundation

final class UpdateSet: Model, @unchecked Sendable {
    static let schema = "updateset"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "symbol")
    var symbol: String
    
    @Field(key: "updateDate")
    var updateDate: Date
    
    init() {
    }
    
    init(id: UUID? = nil, symbol: String, updateDate: Date) {
        self.id = id
        self.symbol = symbol
        self.updateDate = updateDate
    }
}

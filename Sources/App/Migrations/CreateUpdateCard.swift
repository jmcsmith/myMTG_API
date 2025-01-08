//
//  CreateUpdateCard.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/7/25.
//

import Fluent

struct CreateUpdateCard: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("updatecard")
            .id()
            .field("cardUUID", .string)
            .field("cardJSON", .custom("text"))
            .field("updateDate", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("updatecard").delete()
    }
}

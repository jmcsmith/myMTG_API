//
//  CreateUpdateToken.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/8/25.
//

import Fluent


struct CreateUpdateToken: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("updatetoken")
            .id()
            .field("tokenUUID", .string)
            .field("tokenJSON", .custom("text"))
            .field("updateDate", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("updatetoken").delete()
    }
}

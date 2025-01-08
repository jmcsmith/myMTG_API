//
//  CreateUpdateSet.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/7/25.
//

import Fluent

struct CreateUpdateSet: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("updateset")
            .id()
            .field("symbol", .string, .required)
            .field("updateDate", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("updateset").delete()
    }
}

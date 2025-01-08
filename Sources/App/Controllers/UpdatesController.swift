//
//  UpdatesController.swift
//  myMTG_API
//
//  Created by Joseph Beaudoin on 1/7/25.
//


import Fluent
import Vapor

struct UpdatesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let updates = routes.grouped("updates")
        
        updates.get(use: self.index)
        updates.post(use: self.create)
    }
    
    @Sendable
    func index(req: Request) async throws -> [String] {
       
        
        return []
    }
    
    @Sendable
    func create(req: Request) async throws -> String {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let update = try req.content.decode(UpdateDTO.self, using: decoder)
        print(update.updateDate)
        req.logger.info("UpdateDate: \(update.updateDate)")
        
       return "Update created"
    }
}

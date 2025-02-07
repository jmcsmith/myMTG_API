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
    func index(req: Request) async throws -> Updates {

        var cards: [UpdateCard] = []
        var tokens: [UpdateToken] = []
        var sets: [UpdateSet] = []
        let inputString = try req.query.get(String.self, at: "date")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let lastUpdate = dateFormatter.date(from: inputString) ?? Date()
        do {
            cards = try await UpdateCard.query(on: req.db).filter(UpdateCard.self, \.$updateDate >= lastUpdate).sort(UpdateCard.self, \.$updateDate, .descending).all()
            tokens = try await UpdateToken.query(on: req.db).filter(UpdateToken.self, \.$updateDate >= lastUpdate).sort(UpdateToken.self, \.$updateDate, .descending).all()
            sets = try await UpdateSet.query(on: req.db).filter(UpdateSet.self, \.$updateDate >= lastUpdate).sort(UpdateSet.self, \.$updateDate, .descending).all()
        } catch {
            print(error)
        }
        return Updates(updateCards: cards, updateTokens: tokens, updateSets: sets)
    }
    
    @Sendable
    func create(req: Request) async throws -> String {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let update = try req.content.decode(UpdateDTO.self, using: decoder)
        
        //add sets with date
        
        for s in update.newSetCodes {
            let set = UpdateSet(symbol: s, updateDate: update.updateDate)
            do {
                try await set.save(on: req.db)
            } catch {
                print(error)
            }
            print("Added Set: \(s)")
        }
        for c in update.updatedCards {
            let existingCard = try await UpdateCard.query(on: req.db).filter(UpdateCard.self, \UpdateCard.$cardUUID == c.cardUUID).first()
            if let existingCard {
                existingCard.cardJSON = c.cardJSON
                do {
                    try await existingCard.save(on: req.db)
                } catch {
                    print(error)
                }
                print("Updated Card: \(existingCard.cardUUID)")
            }
            else {
                let card = UpdateCard(cardUUID: c.cardUUID, cardJSON: c.cardJSON, cardSetCode: c.cardSetCode, updateDate: update.updateDate)
                do {
                    try await card.save(on: req.db)
                } catch {
                    print(error)
                }
                print("Added Card: \(card.cardUUID)")
            }
        }
        for t in update.updatedTokens {
            let existingToken = try await UpdateToken.query(on: req.db).filter(UpdateToken.self, \UpdateToken.$tokenUUID == t.tokenUUID).first()
            if let existingToken {
                existingToken.tokenJSON = t.tokenJSON
                do {
                    try await existingToken.save(on: req.db)
                } catch {
                    print(error)
                }
                print("Updated Token: \(existingToken.tokenUUID)")
            }
            else {
                let token = UpdateToken(tokenUUID: t.tokenUUID, tokenJSON: t.tokenJSON, tokenSetCode: t.tokenSetCode, updateDate: update.updateDate)
                do {
                    try await token.save(on: req.db)
                } catch {
                    print(error)
                }
                print("Added Token: \(token.tokenUUID)")
            }
        }
        //loop cards
        //check for existing card
        //if found update
        //else insert
        
        print("UpdateDate: \(update.updateDate)")
        
        return "Update created"
    }
}

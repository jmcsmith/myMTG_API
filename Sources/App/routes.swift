import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.routes.defaultMaxBodySize = "100mb"

    try app.register(collection: UpdatesController())
}

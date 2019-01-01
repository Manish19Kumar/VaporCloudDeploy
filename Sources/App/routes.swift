import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // 1. Register a new route at /api/acronyms that accepts a POST request and returns Future<Acronym>. It returns the acronym once it’s saved.
    router.post("api", "acronyms") { req -> Future<Acronym> in
        // 2. Decode the request’s JSON into an Acronym model using Codable. This returns a Future<Acronym> so it uses a flatMap(to:) to extract the acronym when the decoding is complete. Note this is different from how data is decoded in Chapter 2, “Hello Vapor!”. In this route handler, you are calling decode(_:) on Request yourself. You are then unwrapping the result as decode(_:) returns a Future<Acronym>.
        return try req.content.decode(Acronym.self)
            .flatMap(to: Acronym.self) { acronym in
                // 3. Save the model using Fluent. This returns Future<Acronym> as it returns the model once it’s saved.
                return acronym.save(on: req)
        }
    }
}

import Vapor

func routes(_ app: Application) throws {
	app.get { req in
		return "It works!"
	}
	
	app.get("hello") { req -> String in
		return "Hello, world!"
	}
	
	app.get("hello", "vapor") { req in
		return "Hello, Vapor!"
	}
	
	app.get("hello", ":name") { req -> String in
		guard let name = req.parameters.get("name") else {
			throw Abort(HTTPResponseStatus.badRequest)
		}
		return "Hello, \(name)!"
	}

	/*
		curl http://localhost:8080/info \
			-H "Content-Type: application/json" \
			-d '{"name":"Tim"}'
	*/
	app.post("info") { req -> InfoResponse in
		let data = try req.content.decode(InfoData.self)
		return InfoResponse(request: data)
	}
}

struct InfoData: Content {
	let name: String
}

struct InfoResponse : Content {
	let request: InfoData
}

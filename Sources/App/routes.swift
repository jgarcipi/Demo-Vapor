import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("bichos") { req in
        return "Hola, Bichochon !"
    }
//    http://localhost:8080/api/name
    router.get("api", "name") { req -> String in
        let namesArray = ["Chris", "Sarah", "Bob", "Jess"]
        let number = getRandomNumber(0, 3)
        return "Hello, \(namesArray[number])"
    }
    
//http://localhost:8080/api/first_name/junior/last_name/garcia
    router.get("api", "first_name", String.parameter, "last_name", String.parameter) { req -> String in
        let firstName = try req.parameters.next(String.self)
        let lastName = try req.parameters.next(String.self)
        return "Your name is \(firstName) \(lastName)"
    }
    
    
    
    router.post(Person.self, at: "api/name") { (req, data) -> String in
        print("Req -->", req)
        print("data -->", data )
        return "Hello \(data.firstName) \(data.lastName ?? "")"
    }
    
    
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

func getRandomNumber(_ min: Int, _ max: Int) -> Int {
    #if os(Linux)
    return Int(random() % max) + min
    #else
    return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
    #endif
}

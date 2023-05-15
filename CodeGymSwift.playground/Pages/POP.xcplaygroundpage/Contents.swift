//: [Previous](@previous)

/*:
 # POP
 > Nesta seção, você aprenderá sobre a programação orientada a protocolos (POP) em Swift, um paradigma de programação que foca na definição de comportamentos compartilhados por meio de protocolos. A POP permite criar sistemas flexíveis e desacoplados, fornecendo uma alternativa aos padrões orientados a objetos. Vamos explorar os conceitos fundamentais da POP, como a definição de protocolos, conformidade, extensões e como combinar protocolos para criar soluções eficientes.
 */

/*: ### Definindo e Implementando Protocolos: */
// Definindo um protocolo
protocol Drawable {
    func draw()
}

// Implementando um protocolo em uma classe
class Rectangle: Drawable {
    func draw() {
        print("Drawing a rectangle.")
    }
}

// Implementando um protocolo em uma estrutura
struct Circle: Drawable {
    func draw() {
        print("Drawing a circle.")
    }
}

// Conformidade com o protocolo
let drawableObjects: [Drawable] = [Rectangle(), Circle()]

for drawable in drawableObjects {
    drawable.draw() // Drawing a rectangle. / Drawing a circle.
}


/*: ### Protocolos com Requisitos Opcionais: */
import Foundation

// Definindo um protocolo com métodos opcionais
@objc protocol Greetable {
    @objc optional func greet() -> String
}

// Implementando um protocolo com método opcional
class FriendlyGreeter: NSObject, Greetable {
    func greet() -> String {
        return "Hello, friend!"
    }
}

class ShyGreeter: NSObject, Greetable {
    // Método opcional não implementado
}

func performGreeting(greeter: Greetable) {
    if let greeting = greeter.greet?() {
        print(greeting)
    } else {
        print("No greeting provided.")
    }
}

let friendlyGreeter = FriendlyGreeter()
let shyGreeter = ShyGreeter()

performGreeting(greeter: friendlyGreeter) // Hello, friend!
performGreeting(greeter: shyGreeter) // No greeting provided.


/*: ### Protocolos Compostos: */
protocol Drivable {
    func drive()
}

protocol Flyable {
    func fly()
}

struct FlyingCar: Drivable, Flyable {
    func drive() {
        print("Driving the flying car.")
    }

    func fly() {
        print("Flying the flying car.")
    }
}

// Utilizando protocolos compostos em uma função
func performActions(with vehicle: Drivable & Flyable) {
    vehicle.drive()
    vehicle.fly()
}

let flyingCar = FlyingCar()
performActions(with: flyingCar)
// Output:
// Driving the flying car.
// Flying the flying car.


/*: ### Extensões de Protocolo: */
protocol Loggable {
    func log()
}

// Adicionando uma implementação padrão com uma extensão de protocolo
extension Loggable {
    func log() {
        print("Default log message.")
    }
}

struct CustomLogger: Loggable {
    func log() {
        print("Custom log message.")
    }
}

struct DefaultLogger: Loggable {
    // Implementação padrão será utilizada
}

let customLogger = CustomLogger()
customLogger.log() // Custom log message.

let defaultLogger = DefaultLogger()
defaultLogger.log() // Default log message.


/*: ### Protocolos com Tipos Associados: */
protocol Stackable {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}

struct Stack<T>: Stackable {
    private var elements: [T] = []

    mutating func push(_ element: T) {
        elements.append(element)
    }

    mutating func pop() -> T? {
        return elements.popLast()
    }
}

var intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)
print(intStack.pop() ?? "Empty") // 20
print(intStack.pop() ?? "Empty") // 10
print(intStack.pop() ?? "Empty") // Empty


//: [Next](@next)

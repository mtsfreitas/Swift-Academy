//: [Previous](@previous)

/*:
 # OOP
 > Nesta seção, você aprenderá sobre a programação orientada a objetos (OOP) em Swift, um paradigma de programação que permite criar e organizar o código de maneira modular e escalável. A OOP se concentra na organização do código em torno de objetos, que representam entidades e conceitos do mundo real, e suas interações. Vamos explorar os conceitos fundamentais da OOP, como classes, herança, polimorfismo e encapsulamento, e examinar exemplos práticos.
 */

/*: ### Classes e Objetos em Swift: */

// Definindo classes
class Car {
    // Propriedades
    var brand: String
    var model: String
    var year: Int

    // Inicializadores
    init(brand: String, model: String, year: Int) {
        self.brand = brand
        self.model = model
        self.year = year
    }

    // Métodos
    func description() -> String {
        return "\(brand) \(model) (\(year))"
    }
}

// Criando instâncias de objetos
let car = Car(brand: "Ford", model: "Fiesta", year: 2020)
print(car.description()) // Ford Fiesta (2020)

/*: ### Herança e Polimorfismo: */

class ElectricCar: Car {
    // Propriedades
    var batteryCapacity: Int

    // Inicializadores
    init(brand: String, model: String, year: Int, batteryCapacity: Int) {
        self.batteryCapacity = batteryCapacity
        super.init(brand: brand, model: model, year: year)
    }

    // Métodos
    override func description() -> String {
        return "\(super.description()), battery: \(batteryCapacity) kWh"
    }
}

// Criando instâncias de objetos
let electricCar = ElectricCar(brand: "Tesla", model: "Model 3", year: 2021, batteryCapacity: 60)
print(electricCar.description()) // Tesla Model 3 (2021), battery: 60 kWh

/*: ### Encapsulamento e Controle de Acesso: */

class Counter {
    // Encapsulamento: a propriedade "value" é privada e inacessível fora da classe
    private var value: Int = 0

    // Controle de Acesso: a função "increment" é pública e acessível fora da classe
    public func increment() {
        value += 1
    }

    // Controle de Acesso: a função "reset" é pública e acessível fora da classe
    public func reset() {
        value = 0
    }

    // Getters personalizados: a propriedade "currentValue" é somente leitura e acessível fora da classe
    public var currentValue: Int {
        return value
    }
}

let counter = Counter()
counter.increment()
print(counter.currentValue) // 1



/*: ### Protocolos e Delegação: */

// Protocolos
protocol Vehicle {
    var numberOfWheels: Int { get }
    func startEngine()
}

// Implementando um protocolo
class Motorcycle: Vehicle {
    var numberOfWheels: Int {
        return 2
    }

    func startEngine() {
        print("Motorcycle engine started.")
    }
}

// Delegação: a função "startVehicleEngine" recebe um objeto que conforma com o protocolo "Vehicle"
func startVehicleEngine(vehicle: Vehicle) {
    vehicle.startEngine()
}

let motorcycle = Motorcycle()
startVehicleEngine(vehicle: motorcycle) // Motorcycle engine started.



/*: ### Extensões e Herança Múltipla: */

protocol Drivable {
    func drive()
}

protocol Flyable {
    func fly()
}

// Herança múltipla: a classe "FlyingCar" herda de "Vehicle" e implementa os protocolos "Drivable" e "Flyable"
class FlyingCar: Vehicle, Drivable, Flyable {
    var numberOfWheels: Int {
        return 4
    }

    func startEngine() {
        print("Flying car engine started.")
    }

    func drive() {
        print("Driving the flying car.")
    }

    func fly() {
        print("Flying the flying car.")
    }
}

// Extensões: adicionando funcionalidade à classe "FlyingCar" através da conformidade com o protocolo "CustomStringConvertible"
extension FlyingCar: CustomStringConvertible {
    var description: String {
        return "FlyingCar with \(numberOfWheels) wheels"
    }
}

let flyingCar = FlyingCar()
flyingCar.drive() // Driving the flying car.
flyingCar.fly() // Flying the flying car.
print(flyingCar.description) // FlyingCar with 4 wheels




//: [Next](@next)

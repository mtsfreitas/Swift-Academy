/*:
 # Closures
 > As closures são utilizadas para a criação de funções inline. Com elas podemos criar blocos de códigos que podem atuar como variáveis ou funções. Para quem conhece Objective-C, podemos dizer que as closures são equivalentes aos blocos ou, fazendo uma analogia com outras linguagens de programação, podemos dizer que são como callbacks e lambdas.
 */

/*: ### Sintaxe básica de Closures: */

/*
 Closures têm uma sintaxe geral que consiste em argumentos, tipo de retorno e corpo:
 
 { (parametros) -> tipoDeRetorno in
     instruções
 }

*/

// Declarando uma closure
let greetingClosure: (String) -> String = { name in
    return "Olá, \(name)!"
}

// Inferência de tipos e retorno
let greetingClosureInferred = { (name: String) -> String in
    return "Olá, \(name)!"
}

// Parâmetros e retorno explícito
let greetingClosureOneLine: (String) -> String = { "Olá, \($0)!" }

// Closures com múltiplas instruções
let greetingClosureMultiline = { (name: String) -> String in
    let greeting = "Olá"
    return "\(greeting), \(name)!"
}

/*: ### Closures como parâmetros de função: */

func performOperation(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

let sum = performOperation(a: 5, b: 7) { (a, b) -> Int in
    return a + b
}

// Sintaxe de "trailing closure"
let difference = performOperation(a: 5, b: 3) { $0 - $1 }

/*: ### Capturando e referenciando valores em Closures: */

var counter = 0

let incrementCounter = {
    counter += 1
}

incrementCounter()
print(counter) // 1

/*: ### Utilizando Closures em funções de ordem superior: */

let numbers = [1, 2, 3, 4, 5]

let doubledNumbers = numbers.map { $0 * 2 }
print(doubledNumbers) // [2, 4, 6, 8, 10]

let evenNumbers = numbers.filter { $0 % 2 == 0 }
print(evenNumbers) // [2, 4]

let sumOfNumbers = numbers.reduce(0) { $0 + $1 }
print(sumOfNumbers) // 15

/*: ### Closures e memória: */

class MyClass {
    var closure: (() -> Void)?

    func configureClosure() {
        closure = { [weak self] in
            guard let self = self else { return }
            print("Closure executada na instância de MyClass: \(self)")
        }
    }

    deinit {
        print("MyClass deinit")
    }
}

var myClassInstance: MyClass? = MyClass()
myClassInstance?.configureClosure()
myClassInstance?.closure?()
myClassInstance = nil // MyClass deinit


//: [Next](@next)

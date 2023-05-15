//: [Previous](@previous)

/*:
 # Generics
 > Nesta seção, você aprenderá sobre generics em Swift, uma poderosa funcionalidade que permite criar código flexível e reutilizável. Generics permitem que você escreva funções, classes, estruturas e enumerações que funcionem com diferentes tipos, mantendo a segurança e eficiência do tipo. Vamos explorar os conceitos básicos de generics, como aplicá-los em seu código e examinar exemplos práticos..
 */

/*: ### Funções Genéricas: */

func swapValues<T>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}

var intA = 5
var intB = 10
swapValues(a: &intA, b: &intB)
print("Inteiros trocados: \(intA), \(intB)")

var stringA = "Hello"
var stringB = "World"
swapValues(a: &stringA, b: &stringB)
print("Strings trocadas: \(stringA), \(stringB)")


/*: ### Classes, Estruturas e Enumerações Genéricas: */

struct Stack<Element> {
    private var items = [Element]()

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        return items.popLast()
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print(intStack.pop()!) // 2

/*: ### Tipos Associados e Protocolos Genéricos: */

protocol Container {
    associatedtype ItemType

    mutating func add(_ item: ItemType)
    var count: Int { get }
}

extension Stack: Container {
    mutating func add(_ item: Element) {
        push(item)
    }

    var count: Int {
        return items.count
    }
}

/*: ### Extensões Genéricas e Métodos de Extensão Genéricos: */

extension Array {
    func customMap<T>(_ transform: (Element) -> T) -> [T] {
        var result = [T]()
        for item in self {
            result.append(transform(item))
        }
        return result
    }
}

let numbers = [1, 2, 3, 4]
let doubledNumbers = numbers.customMap { $0 * 2 }
print(doubledNumbers) // [2, 4, 6, 8]


/*: ### Usando Generics em funções de ordem superior: */

func filterElements<T>(_ items: [T], _ isIncluded: (T) -> Bool) -> [T] {
    var result = [T]()
    for item in items {
        if isIncluded(item) {
            result.append(item)
        }
    }
    return result
}

let evenNumbers = filterElements(numbers) { $0 % 2 == 0 }
print(evenNumbers) // [2, 4]


//: [Next](@next)

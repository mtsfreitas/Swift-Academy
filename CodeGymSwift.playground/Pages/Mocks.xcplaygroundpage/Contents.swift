//: [Previous](@previous)

import Foundation

/*:
 # Mocks
 > Os mocks são objetos que imitam o comportamento de outros objetos em um sistema. Eles são úteis para isolar partes do código e garantir que você possa testar cada componente individualmente. Neste tutorial, você aprenderá a criar e usar mocks em Swift para facilitar o teste unitário de seu código.
 */

/*: ###Protocolos e Mocks */
// Uma maneira comum de criar mocks em Swift é usar protocolos. Ao definir um protocolo para um objeto que você deseja imitar, você pode criar uma implementação de mock que adere ao mesmo protocolo.

// Defina o protocolo
// Primeiro, defina um protocolo que descreve o comportamento do objeto que você deseja imitar. Por exemplo, considere uma classe NetworkService que faz solicitações de rede:

protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void)
}

// Este protocolo define um único método, fetchData(completion:), que busca dados e chama o bloco de conclusão com um resultado.

// Implemente a classe real
// Agora, implemente a classe real que adere ao protocolo:

class NetworkService: NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        // Implementação real que busca dados da rede
    }
}

// Esta é a implementação real da classe NetworkService que faz solicitações de rede para buscar dados.

//  Crie a implementação de mock
// Em seguida, crie uma implementação de mock que também adere ao protocolo:

class MockNetworkService: NetworkServiceProtocol {
    var data: Data?
    var error: Error?

    init(data: Data? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }

    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else if let error = error {
            completion(.failure(error))
        } else {
            fatalError("Data and error cannot both be nil.")
        }
    }
}

// A classe MockNetworkService permite que você forneça dados simulados ou um erro simulado que será retornado quando o método fetchData(completion:) for chamado. Isso permite testar diferentes cenários sem realmente fazer solicitações de rede.

/*: ### Usando Mocks nos Testes */
// Agora que você criou mocks para seu objeto, você pode usá-los em testes unitários.

// Importe XCTest
// Crie um novo arquivo de teste no Xcode e importe o framework XCTest:

import XCTest
@testable import YourAppModuleName

// Escreva testes usando mocks
// Agora, você pode escrever testes que usam a implementação de mock em vez da implementação real. Por exemplo, você pode testar como sua classe lida com o sucesso e a falha ao buscar dados:
class NetworkServiceTests: XCTestCase {
    func testFetchDataSuccess() {
        let mockData = Data("Test data".utf8)
        let mockService = MockNetworkService(data: mockData)
        
        let expectation = XCTestExpectation(description: "Fetch data successfully")
        
        mockService.fetchData { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, mockData)
            case .failure(_):
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchDataFailure() {
        let mockError = NSError(domain: "MockError", code: -1, userInfo: nil)
        let mockService = MockNetworkService(error: mockError)
        
        let expectation = XCTestExpectation(description: "Fetch data with failure")
        
        mockService.fetchData { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error as NSError, mockError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

// Neste exemplo, você escreveu dois testes: um que verifica se a classe lida corretamente com o sucesso ao buscar dados e outro que verifica se a classe lida corretamente com a falha. Em ambos os casos, você usou a implementação de mock `MockNetworkService` para fornecer os dados ou erros simulados.

// Neste tutorial, você aprendeu como criar e usar mocks em Swift usando protocolos. Os mocks são uma ferramenta poderosa para isolar componentes em seu código e garantir que você possa testá-los individualmente. Ao criar implementações de mock para seus objetos e usá-las em testes unitários, você pode melhorar a qualidade do seu código e torná-lo mais fácil de manter e depurar.









//: [Next](@next)

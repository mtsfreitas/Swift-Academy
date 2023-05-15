//: [Previous](@previous)

/*:
 # Concorrência
 > A concorrência é uma técnica usada para executar várias tarefas simultaneamente, o que pode melhorar significativamente a performance e a capacidade de resposta de seu aplicativo. Swift oferece várias maneiras de lidar com a concorrência, incluindo GCD (Grand Central Dispatch) e async/await. Neste tutorial, você aprenderá como usar a concorrência em Swift.
 */

/*: ### GCD (Grand Central Dispatch) */
// GCD é uma biblioteca de gerenciamento de threads de baixo nível desenvolvida pela Apple que facilita a execução de tarefas concorrentes. A GCD gerencia filas de tarefas e aloca recursos do sistema de acordo com a prioridade e a disponibilidade.

/*: ### Executando tarefas em paralelo com GCD */
// Criando uma fila de despacho: Para criar uma fila de despacho, você pode usar uma das filas globais fornecidas pelo sistema ou criar uma fila personalizada.

import Dispatch
import Foundation

// Acessando uma fila global
let globalQueue = DispatchQueue.global()

// Criando uma fila personalizada
let customQueue = DispatchQueue(label: "com.example.myCustomQueue")

// Executando tarefas assíncronas: Para executar uma tarefa assincronamente em uma fila, você pode usar o método async:

globalQueue.async {
    print("Executando tarefa assíncrona.")
}

// Aguardando a conclusão de uma tarefa: Para aguardar a conclusão de uma tarefa antes de prosseguir, você pode usar o método sync:

customQueue.sync {
    print("Executando tarefa síncrona.")
}

// Executando tarefas após um determinado intervalo de tempo: Você pode executar uma tarefa após um determinado intervalo de tempo usando o método asyncAfter:

let delay = DispatchTimeInterval.seconds(2)

globalQueue.asyncAfter(deadline: .now() + delay) {
    print("Executando tarefa após 2 segundos.")
}

/*: ### Async/Await */

// A partir do Swift 5.5, a linguagem introduziu o conceito de async/await, que simplifica significativamente a escrita e a compreensão do código concorrente.

// Criando uma função assíncrona: Para criar uma função assíncrona, adicione a palavra-chave async antes da palavra-chave func:

func fetchData() async -> Data {
    // Simulando uma operação de busca de dados
    Thread.sleep(forTimeInterval: 2.0)
    return Data()
}

// Chamando uma função assíncrona: Para chamar uma função assíncrona, use a palavra-chave await:

func processData() async {
    let data = await fetchData()
    print("Dados recebidos: \(data)")
}

// Usando async/await em um closure: Para usar o async/await em um closure, adicione a palavra-chave @escaping antes do tipo de retorno e a palavra-chave async antes do corpo do closure:

func performAsyncTask(completion: @escaping () async -> Void) {
    DispatchQueue.global().async {
        await completion()
    }
}

performAsyncTask {
    print("Iniciando tarefa assíncrona.")
    await processData()
    print("Tarefa assíncrona concluída.")
}

// Tratamento de erros com async/await**: Para tratar erros em funções assíncronas, use a palavra-chave `throws` ao definir a função e a palavra-chave `try` ao chamá-la:

enum DataError: Error {
    case invalidData
}

func fetchData() async throws -> Data {
    // Simulando uma operação de busca de dados
    Thread.sleep(forTimeInterval: 2.0)
    if Bool.random() {
        return Data()
    } else {
        throw DataError.invalidData
    }
}

func processData() async {
    do {
        let data = try await fetchData()
        print("Dados recebidos: \(data)")
    } catch {
        print("Erro ao buscar dados: \(error)")
    }
}

Task {
    await processData()
}

// Usando async/await com DispatchGroup: Quando você precisa executar várias tarefas assíncronas e aguardar a conclusão de todas elas antes de continuar, você pode usar DispatchGroup com async/await:

func fetchAllData() async {
    let group = DispatchGroup()
    var allData: [Data] = []

    for _ in 0..<5 {
        group.enter()
        Task {
            defer { group.leave() }
            let data = await fetchData()
            allData.append(data)
        }
    }

    group.wait()
    print("Todos os dados foram buscados: \(allData)")
}

Task {
    await fetchAllData()
}



//: [Next](@next)

//: [Previous](@previous)

import Foundation

/*:
 # URL Loading System
 > O URL Loading System é uma parte fundamental do framework Foundation em iOS, macOS e outras plataformas da Apple. Ele permite carregar recursos da web, como dados e imagens, de maneira eficiente e segura. Neste tutorial, você aprenderá como usar o URL Loading System em Swift para enviar solicitações de rede e lidar com respostas.
 */

/*: ### URLSession e URLRequest */
// As classes principais do URL Loading System são URLSession e URLRequest. A URLSession é responsável por gerenciar sessões de rede, enquanto a URLRequest representa uma solicitação de rede específica.

/*: ### Criando uma URLRequest */
// Para criar uma URLRequest, primeiro você precisa de uma URL:

func fetchData() {
    guard let url = URL(string: "https://api.example.com/data") else {
        print("URL inválida.")
        return
    }
    
    // Restante do código de exemplo (URLRequest, URLSession, etc.)
    
    
    
    // Em seguida, crie uma URLRequest com a URL:
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    
    // Aqui, definimos o método HTTP como "GET". Você pode alterá-lo para "POST", "PUT", "DELETE" ou qualquer outro método HTTP conforme necessário.
    
    /*: ### Criando uma URLSession */
    // Crie uma instância de URLSession para gerenciar a sessão de rede:
    let session = URLSession.shared
    
    // Neste exemplo, usamos a sessão compartilhada (URLSession.shared), que é adequada para solicitações de rede simples e eficientes. Se você precisar de mais controle sobre a configuração da sessão, como tempo limite ou políticas de cache, você pode criar uma sessão personalizada usando URLSession(configuration:).
    
    /*: ###  Enviando a solicitação e lidando com a resposta */
    // Para enviar a solicitação e lidar com a resposta, use o método dataTask(with:completionHandler:) da URLSession:
    
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Erro na solicitação: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Resposta inválida.")
            return
        }
        
        guard let data = data else {
            print("Dados não recebidos.")
            return
        }
        
        // Processar os dados recebidos
        print("Dados recebidos: \(data)")
    }
    
    task.resume()
    
    // O método dataTask(with:completionHandler:) retorna um objeto URLSessionDataTask. Para iniciar a tarefa, chame o método resume().
    
    /*: ###  Decodificando dados JSON */
    // Se a resposta da API for no formato JSON, você pode usar a classe JSONDecoder para decodificar os dados em um objeto Swift:
    struct MyData: Codable {
        let id: Int
        let name: String
    }
    
    let task = session.dataTask(with: request) { (data, response, error) in
        // ... (código anterior)
        
        do {
            let decoder = JSONDecoder()
            let myData = try decoder.decode(MyData.self, from: data)
            print("Dados decodificados: \(myData)")
        } catch {
            print("Erro ao decodificar JSON: \(error)")
        }
    }
    
    task.resume()
    
}

//: [Next](@next)

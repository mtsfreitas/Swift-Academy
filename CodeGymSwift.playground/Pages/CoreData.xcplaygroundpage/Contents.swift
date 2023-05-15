//: [Previous](@previous)

/*:
 # Core Data
 > O Core Data é um framework de persistência de dados desenvolvido pela Apple para aplicativos iOS e macOS. Ele permite armazenar, gerenciar e manipular dados de maneira eficiente usando um modelo de dados orientado a objetos. Neste tutorial, você aprenderá como usar o Core Data em Swift.
 */

/*: ### Configuração do Core Data */
/*: ## Adicione o modelo de dados Core Data */
/*
Crie um arquivo de modelo de dados no Xcode:

Clique com o botão direito do mouse na pasta do seu projeto no navegador do projeto.
 
Selecione "New File..." (Novo Arquivo).
 
Escolha "Data Model" (Modelo de Dados) na categoria "Core Data" e clique em "Next" (Avançar).
 
Dê um nome ao arquivo de modelo de dados (por exemplo, "MyDataModel") e clique em "Create" (Criar).
 
*/

/*: ## Crie entidades e atributos */
/*
 Abra o arquivo de modelo de dados recém-criado e defina entidades e atributos:

 Clique no botão "Add Entity" (Adicionar Entidade) na parte inferior da tela.
 Selecione a entidade criada e, no painel "Attributes" (Atributos) à direita, clique no botão "+" para adicionar um novo atributo.
 Defina o nome e o tipo de dados do atributo.
 
 Por exemplo, você pode criar uma entidade chamada "Person" com os atributos "name" (String) e "age" (Int).
 
*/

/*: ## Gere classes gerenciadas pelo Core Data */
/*
 O Xcode pode gerar automaticamente classes gerenciadas pelo Core Data com base nas entidades definidas em seu arquivo de modelo de dados:

 Selecione a entidade na tela do modelo de dados.
 No painel "Data Model Inspector" à direita, selecione "Class Definition" (Definição de Classe) no menu suspenso "Codegen".
 No menu "Product" (Produto), selecione "Clean Build Folder" (Limpar Pasta de Compilação) e, em seguida, construa seu projeto (Cmd + B).
 
 O Xcode gerará classes gerenciadas pelo Core Data correspondentes às entidades definidas. Por exemplo, para a entidade "Person", você terá uma classe chamada "Person".
 
*/

/*: ## Usando o Core Data */

//Agora que você configurou o Core Data em seu projeto, é hora de usá-lo para armazenar e recuperar dados.

/*: ## Configure o Core Data Stack */
/*
 O Core Data Stack consiste em várias classes que trabalham juntas para gerenciar a persistência de dados, como NSPersistentContainer, NSManagedObjectContext e NSPersistentStoreCoordinator. Para simplificar, você pode usar a classe NSPersistentContainer para configurar o Core Data Stack.

 Em um projeto de aplicativo, você pode adicionar o seguinte código no arquivo AppDelegate.swift:
 
*/

import CoreData

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // ...
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(erroruserInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // UIApplicationDelegate methods
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
}

//Este código cria um `NSPersistentContainer` com o nome do arquivo de modelo de dados e define um método `saveContext()` para salvar as alterações no contexto.


/*: ## Adicionar e salvar objetos */
// Para adicionar e salvar objetos no Core Data, você precisa acessar o `NSManagedObjectContext`:
func addPerson(name: String, age: Int) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let person = Person(context: context)
    person.name = name
    person.age = Int16(age)
    
    do {
        try context.save()
    } catch {
        print("Erro ao salvar pessoa: \(error)")
    }
}
// Este exemplo define uma função addPerson(name:age:) que cria um objeto Person, define seus atributos e salva o objeto no Core Data.


/*: ## Recuperar objetos */
// Para recuperar objetos do Core Data, você precisa criar uma solicitação de busca (NSFetchRequest) e executá-la no contexto:

func fetchAllPersons() -> [Person]? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
    
    do {
        let persons = try context.fetch(fetchRequest)
        return persons
    } catch {
        print("Erro ao buscar pessoas: \(error)")
        return nil
    }
}

// Este exemplo define uma função fetchAllPersons() que retorna todos os objetos Person armazenados no Core Data.

/*: ## Atualizar objetos */
// Para atualizar objetos no Core Data, basta modificar seus atributos e salvar o contexto:

func updatePerson(person: Person, newName: String, newAge: Int) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    person.name = newName
    person.age = Int16(newAge)
    
    do {
        try context.save()
    } catch {
        print("Erro ao atualizar pessoa: \(error)")
    }
}

// Este exemplo define uma função updatePerson(person:newName:newAge:) que atualiza os atributos de um objeto Person e salva as alterações no Core Data.

/*: ## Excluir objetos */
// Para excluir objetos do Core Data, use o método delete(_:) do contexto e salve as alterações:

func deletePerson(person: Person) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    context.delete(person)
    
    do {
        try context.save()
    } catch {
        print("Erro ao excluir pessoa: \(error)")
    }
}

// Este exemplo define uma função deletePerson(person:) que exclui um objeto Person do Core Data e salva as alterações.

//: [Next](@next)

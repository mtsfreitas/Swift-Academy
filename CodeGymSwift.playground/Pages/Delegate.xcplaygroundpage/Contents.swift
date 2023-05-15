//: [Previous](@previous)

import UIKit

/*:
 # Delegate
 > O delegate é um padrão de design comum no desenvolvimento iOS e é usado para permitir que uma classe delegue parte de sua funcionalidade a outra. Ele é especialmente útil quando você precisa customizar a maneira como diferentes componentes do seu aplicativo interagem uns com os outros sem criar dependências rígidas entre as classes. Neste tutorial, você aprenderá como usar o padrão de delegate em Swift.
 */

/*: ### Crie o protocolo de delegação: */
// Primeiro, você precisa criar um protocolo que define os métodos e propriedades que serão delegados. Um protocolo é uma lista de requisitos que uma classe, estrutura ou enum pode adotar para fornecer uma funcionalidade específica.

protocol CustomDelegate: AnyObject {
    func didTapButton()
}

/*: ### Adicione uma propriedade delegate à classe que delega: */
// Agora, adicione uma propriedade delegate à classe que delegará parte de sua funcionalidade. Essa propriedade deve ser do tipo do protocolo que você acabou de criar.

class ButtonHandler {
    weak var delegate: CustomDelegate?
    
    func buttonTapped() {
        delegate?.didTapButton()
    }
}

// Note que a propriedade delegate é marcada como weak para evitar referências fortes e ciclos de retenção, já que delegates geralmente criam relações entre objetos.


/*: ### Faça a classe que recebe a delegação adotar o protocolo: */
// A classe que receberá a delegação precisa adotar o protocolo e implementar seus requisitos.

class ViewController: UIViewController, CustomDelegate {
    let buttonHandler = ButtonHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonHandler.delegate = self
    }

    func didTapButton() {
        print("Botão foi pressionado!")
    }
}

// Aqui, a classe ViewController adota o protocolo CustomDelegate e implementa o método didTapButton(). Além disso, ela define a si mesma como delegate do objeto buttonHandler.

/*: ### Teste a funcionalidade: */
// Agora você pode testar a funcionalidade delegada chamando o método buttonTapped() no objeto buttonHandler. Quando isso acontecer, o método didTapButton() será chamado na classe ViewController, que é a delegate.

// buttonHandler.buttonTapped() // "Botão foi pressionado!" será impresso no console



//: [Next](@next)

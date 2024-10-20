import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка фона
        view.backgroundColor = .white
        
        // Пример добавления кнопки
        let button = UIButton(type: .system)
        button.setTitle("Press Me", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        view.addSubview(button)
    }
    
    // Функция, которая будет вызываться при нажатии на кнопку
    @objc func buttonPressed() {
        print("Button Pressed!")
    }
}

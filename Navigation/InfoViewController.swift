import UIKit

class InfoViewController: UIViewController {
    
    // Кнопка через замыкание
    private let showAlertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Alert", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Info"
        
        // Добавляем кнопку на экран
        view.addSubview(showAlertButton)
        
        // Добавляем действие для кнопки
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        // Настройка Auto Layout для кнопки
        setupConstraints()
    }

    // Настройка ограничений Auto Layout
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showAlertButton.widthAnchor.constraint(equalToConstant: 200),
            showAlertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK Pressed")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel Pressed")
        }))
        present(alertController, animated: true, completion: nil)
    }
}

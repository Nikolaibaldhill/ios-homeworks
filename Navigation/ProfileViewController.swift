import UIKit

class ProfileViewController: UIViewController {

    // Создаём переменную для экземпляра ProfileHeaderView
    let headerView = ProfileHeaderView()

    // Создаем новую кнопку
    let newButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Новая кнопка", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Установка светло-серого фона
        view.backgroundColor = .lightGray

        // Установка заголовка
        title = "Profile"

        // Отключаем использование автоматических ограничений по умолчанию
        headerView.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем headerView как subview
        view.addSubview(headerView)

        // Добавляем кнопку на экран
        view.addSubview(newButton)

        // Устанавливаем Auto Layout для headerView и кнопки
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Установка Auto Layout для headerView
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),

            // Установка Auto Layout для новой кнопки
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 50) // Опционально можно задать высоту кнопки
        ])
    }
}

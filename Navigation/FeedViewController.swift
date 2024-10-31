import UIKit

class FeedViewController: UIViewController {
    
    // Создаем UIStackView с вертикальной ориентацией
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // Создаем две кнопки
    private let firstButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть пост 1", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть пост 2", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Feed"

        // Добавляем UIStackView на экран
        view.addSubview(stackView)

        // Добавляем кнопки в UIStackView
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)

        // Настройка Auto Layout для UIStackView
        setupConstraints()

        // Добавляем обработчики для кнопок
        firstButton.addTarget(self, action: #selector(openPost1), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(openPost2), for: .touchUpInside)
    }

    // Настройка Auto Layout для UIStackView
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }

    // Открытие PostViewController при нажатии на первую кнопку
    @objc func openPost1() {
        let post = Post(
            title: "First Post",
            author: "John Doe",
            description: "This is the first post",
            image: "image1",
            likes: 120,
            views: 240
        )
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }

    @objc func openPost2() {
        let post = Post(
            title: "Second Post",
            author: "Jane Smith",
            description: "This is the second post",
            image: "image2",
            likes: 95,
            views: 180
        )
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }

}


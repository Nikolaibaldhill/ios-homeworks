import UIKit

class FeedViewController: UIViewController {
    
    // Создаем кнопку через замыкание
    private let showPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Post", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Feed"

        // Добавляем кнопку на экран
        view.addSubview(showPostButton)
        
        // Добавляем обработчик нажатия на кнопку
        showPostButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        
        // Настройка Auto Layout для кнопки
        setupConstraints()
    }
    
    // Функция для настройки ограничений Auto Layout
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            showPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showPostButton.widthAnchor.constraint(equalToConstant: 200),
            showPostButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Обработка нажатия на кнопку
    @objc func showPost() {
        let post = Post(title: "First Post")
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}


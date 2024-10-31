import UIKit

class ProfileViewController: UIViewController {

    // Экземпляр UITableView для отображения списка публикаций
    let tableView = UITableView()
    
    // Массив публикаций для отображения в таблице
    let posts: [Post] = [
        Post(title: "First Post", author: "John Doe", description: "First post description", image: "image1", likes: 120, views: 240),
        Post(title: "Second Post", author: "Jane Smith", description: "Second post description", image: "image2", likes: 95, views: 180),
        Post(title: "Third Post", author: "Alex Brown", description: "Third post description", image: "image3", likes: 250, views: 300),
        Post(title: "Fourth Post", author: "Emily White", description: "Fourth post description", image: "image4", likes: 75, views: 90)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Profile"
        
        // Настройка и добавление tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Настройка делегата и источника данных для tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Регистрация кастомной ячейки
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        // Закрепляем tableView к краям экрана
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Количество строк равно количеству публикаций
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Используем PostTableViewCell для отображения публикации
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        // Настраиваем ячейку с данными из публикации
        let post = posts[indexPath.row]
        cell.configure(with: post)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    // Методы делегата можно добавить по необходимости
}

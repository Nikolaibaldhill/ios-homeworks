import UIKit

class PostViewController: UIViewController {
    var post: Post? // Переменная для хранения выбранного поста

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка фона и заголовка
        view.backgroundColor = .lightGray
        title = post?.title ?? "Post Details" // Используем заголовок публикации или дефолтный текст

        // Добавляем кнопку для открытия InfoViewController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfo))
    }

    // Метод для открытия InfoViewController
    @objc func showInfo() {
        let infoViewController = InfoViewController()
        let navController = UINavigationController(rootViewController: infoViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}

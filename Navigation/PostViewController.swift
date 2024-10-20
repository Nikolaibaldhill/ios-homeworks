import UIKit

struct Post {
    let title: String
}

class PostViewController: UIViewController {
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = post?.title ?? "Post Details" // Если post не инициализирован, отображаем дефолтный заголовок

        // Добавляем кнопку для открытия InfoViewController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfo))
    }

    @objc func showInfo() {
        // Создаем экземпляр InfoViewController и модально отображаем его
        let infoViewController = InfoViewController()
        let navController = UINavigationController(rootViewController: infoViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}

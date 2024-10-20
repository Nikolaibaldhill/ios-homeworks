import UIKit

class ProfileViewController: UIViewController {

    // Создаём переменную для экземпляра ProfileHeaderView
    let headerView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Установка светло-серого фона
        view.backgroundColor = .lightGray

        // Установка заголовка
        title = "Profile"

        // Добавляем headerView как subview
        self.view.addSubview(headerView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Устанавливаем frame для headerView, равный frame корневого view
        headerView.frame = self.view.frame
    }
}


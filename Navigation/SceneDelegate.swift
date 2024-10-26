import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Создаем TabBarController
        let tabBarController = UITabBarController()

        // Настройка вкладок
        let feedNavigationController = createNavigationController(
            rootViewController: FeedViewController(),
            title: "Feed",
            imageName: "house.fill"
        )
        
        let profileNavigationController = createNavigationController(
            rootViewController: LogInViewController(),  // Изменили на LogInViewController
            title: "Profile",
            imageName: "person.fill"
        )

        // Добавляем навигационные контроллеры в TabBarController
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        
        // Настройка окна
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    // Функция для создания UINavigationController
    private func createNavigationController(rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: imageName)
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationController
    }
}

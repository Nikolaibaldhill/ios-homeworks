import UIKit

// Расширение для установки альфа-канала у UIImage
extension UIImage {
    func withAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

class LogInViewController: UIViewController {

    // MARK: - UI Elements

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // Иконка VK
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "VKLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        // Если нужно скругление углов и обрезка изображения
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    // Поле для ввода Email или телефона
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "VKBlue") ?? .systemBlue
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        // Отступ слева
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        // Настройки клавиатуры
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        return textField
    }()

    // Поле для ввода пароля
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "VKBlue") ?? .systemBlue
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        // Отступ слева
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        // Настройки клавиатуры
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        return textField
    }()

    // Кнопка Log In
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true // Важно для корректного отображения скругленных углов
        button.translatesAutoresizingMaskIntoConstraints = false

        if let bluePixel = UIImage(named: "blue_pixel") {
            // Растягиваем изображение, чтобы оно заполнило кнопку
            let resizableImage = bluePixel.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            button.setBackgroundImage(resizableImage, for: .normal)
            button.setBackgroundImage(resizableImage.withAlpha(0.8), for: .selected)
            button.setBackgroundImage(resizableImage.withAlpha(0.8), for: .highlighted)
            button.setBackgroundImage(resizableImage.withAlpha(0.8), for: .disabled)
        } else {
            // Используем цвет VKBlue, если изображение не найдено
            button.backgroundColor = UIColor(named: "VKBlue") ?? UIColor(red: 76/255, green: 133/255, blue: 204/255, alpha: 1)
        }

        return button
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setupActions()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Добавляем наблюдателей клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Удаляем наблюдателей клавиатуры
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        contentView.addSubview(logoImageView)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Настройки для logoImageView
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            // Настройки для emailTextField
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            // Настройки для passwordTextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            // Настройки для logInButton
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Actions

    private func setupActions() {
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }

    @objc private func logInButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your email and password")
            return
        }
        print("Log In button tapped")

        // Создаем экземпляр ProfileViewController
        let profileVC = ProfileViewController()

        // Переходим на ProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Keyboard Handling

    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    // Скрытие клавиатуры при тапе на пустое место
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            logInButtonTapped()
        }
        return true
    }
}


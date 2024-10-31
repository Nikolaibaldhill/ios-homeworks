import UIKit

class ProfileHeaderView: UIView {

    // Элементы интерфейса
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_image")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Введите имя"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Ваш статус:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите новый статус"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Установить статус", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)

        // Добавляем обработчик для кнопки
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Аватарка
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            // Имя пользователя
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 27),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            // Статус пользователя
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 34),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 27),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            // Поле для ввода статуса
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 27),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            // Кнопка
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 20),
            setStatusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            setStatusButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // Функция, вызываемая при нажатии на кнопку
    @objc func buttonPressed() {
        let newStatus = statusTextField.text ?? "Статус отсутствует"
        statusLabel.text = newStatus
        print("Статус пользователя: \(newStatus)")
    }
}

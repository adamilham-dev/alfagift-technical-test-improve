//
//  AddStudentViewController.swift
//  student
//
//  Created by Adam on 25/01/25.
//

import UIKit
import RAGTextField

protocol AddStudentDelegate: AnyObject {
    func didAddStudent(_ student: Student)
}

class AddStudentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate: AddStudentDelegate?

    private var selectedImage: UIImage?

    private let avatarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 60
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder_avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Avatar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(uploadAvatarTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let firstNameField = AddStudentViewController.createRAGTextField(placeholder: "First Name")
    private let lastNameField = AddStudentViewController.createRAGTextField(placeholder: "Last Name")
    private let emailField = AddStudentViewController.createRAGTextField(placeholder: "Email")
    private let addressField = AddStudentViewController.createRAGTextField(placeholder: "Address")

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(saveStudent), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupGradientBackground()
        setupNavigationBar()

        view.addSubview(avatarContainerView)
        avatarContainerView.addSubview(avatarImageView)
        view.addSubview(uploadButton)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(emailField)
        view.addSubview(addressField)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            avatarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarContainerView.widthAnchor.constraint(equalToConstant: 120),
            avatarContainerView.heightAnchor.constraint(equalToConstant: 120),

            avatarImageView.centerXAnchor.constraint(equalTo: avatarContainerView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarContainerView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),

            uploadButton.topAnchor.constraint(equalTo: avatarContainerView.bottomAnchor, constant: 10),
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.widthAnchor.constraint(equalToConstant: 120),
            uploadButton.heightAnchor.constraint(equalToConstant: 40),

            firstNameField.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 20),
            firstNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 10),
            lastNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 10),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            addressField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            addressField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            saveButton.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Add Student"
    }

    @objc private func uploadAvatarTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        let alert = UIAlertController(title: "Choose Avatar", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
        })
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @objc private func saveStudent() {
        guard let firstName = firstNameField.text, !firstName.isEmpty,
              let lastName = lastNameField.text, !lastName.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let address = addressField.text, !address.isEmpty else {
            showError(message: "All fields are required.")
            return
        }

        let avatarData = selectedImage?.jpegData(compressionQuality: 0.8)
        let avatarBase64 = avatarData?.base64EncodedString() ?? "https://via.placeholder.com/150"

        let newStudent = Student(
            id: Int.random(in: 1...1000),
            first_name: firstName,
            last_name: lastName,
            email: email,
            avatar: avatarBase64,
            address: address
        )

        delegate?.didAddStudent(newStudent)
        navigationController?.popViewController(animated: true)
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            avatarImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            avatarImageView.image = originalImage
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    static func createRAGTextField(placeholder: String) -> RAGTextField {
        let textField = RAGTextField()
        let bgView = OutlineView(frame: .zero)
        bgView.lineWidth = 1
        bgView.lineColor = .white
        bgView.fillColor = UIColor.white.withAlphaComponent(0.2)
        bgView.cornerRadius = 8.0
        textField.textBackgroundView = bgView
        textField.textPadding = UIEdgeInsets(top: 10.0, left: 12.0, bottom: 10.0, right: 12.0)
        textField.textPaddingMode = .text
        textField.placeholderMode = .scalesWhenEditing
        textField.placeholderScaleWhenEditing = 0.6
        textField.placeholder = placeholder
        textField.placeholderColor = .white
        textField.textColor = .white
        textField.tintColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}

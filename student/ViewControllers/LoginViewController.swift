//
//  LoginViewController.swift
//  student
//
//  Created by Adam on 24/01/25.
//

import UIKit
import RAGTextField

class LoginViewController: UIViewController {
    // Particle emitter
    private let particleEmitter = CAEmitterLayer()

    // Illustration image
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "illustration") // Replace with your actual image name
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Title and subtitle
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back,"
        label.font = UIFont(name: "AvenirNext-Bold", size: 28)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in now to continue"
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Username field
    private let usernameField: RAGTextField = {
        let field = RAGTextField()
        let bgView = OutlineView(frame: .zero)
        bgView.lineWidth = 1
        bgView.lineColor = .white
        bgView.fillColor = UIColor.white.withAlphaComponent(0.2)
        bgView.cornerRadius = 8.0
        field.textBackgroundView = bgView
        field.textPadding = UIEdgeInsets(top: 10.0, left: 12.0, bottom: 10.0, right: 12.0)
        field.textPaddingMode = .text
        field.placeholderMode = .scalesWhenEditing
        field.placeholderScaleWhenEditing = 0.6
        field.placeholder = "Username"
        field.placeholderColor = .white
        field.textColor = .white
        field.tintColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    // Password field
    private let passwordField: RAGTextField = {
        let field = RAGTextField()
        let bgView = OutlineView(frame: .zero)
        bgView.lineWidth = 1
        bgView.lineColor = .white
        bgView.fillColor = UIColor.white.withAlphaComponent(0.2)
        bgView.cornerRadius = 8.0
        field.textBackgroundView = bgView
        field.textPadding = UIEdgeInsets(top: 10.0, left: 12.0, bottom: 10.0, right: 12.0)
        field.textPaddingMode = .text
        field.placeholderMode = .scalesWhenEditing
        field.placeholderScaleWhenEditing = 0.6
        field.placeholder = "Password"
        field.placeholderColor = .white
        field.textColor = .white
        field.tintColor = .white
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    // Login button
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 22
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 16)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupParticles()
    }

    private func setupUI() {
        setupGradientBackground()

        // Add subviews
        view.addSubview(illustrationImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)

        // Apply constraints
        NSLayoutConstraint.activate([
            // Illustration image
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            illustrationImageView.widthAnchor.constraint(equalToConstant: 250),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 200),

            // Title
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 20),

            // Subtitle
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

            // Username field
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            usernameField.widthAnchor.constraint(equalToConstant: 300),
            usernameField.heightAnchor.constraint(equalToConstant: 50),

            // Password field
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            passwordField.widthAnchor.constraint(equalToConstant: 300),
            passwordField.heightAnchor.constraint(equalToConstant: 50),

            // Login button
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupParticles() {
        // Configure the particle emitter
        particleEmitter.emitterShape = .line
        particleEmitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -10)
        particleEmitter.emitterSize = CGSize(width: view.bounds.width, height: 1)

        let particle = CAEmitterCell()
        particle.birthRate = 10 // Emit 10 particles per second
        particle.lifetime = 8.0 // Particles will last for 8 seconds
        particle.lifetimeRange = 2.0 // Randomize lifetime slightly
        particle.velocity = 50 // Speed of particles
        particle.velocityRange = 20 // Add some variation to velocity
        particle.scale = 0.1 // Base size of the particle
        particle.scaleRange = 0.05 // Add size variation
        particle.alphaRange = 0.3 // Start with a semi-transparent particle
        particle.alphaSpeed = -0.02 // Gradually fade out
        particle.contents = createParticleShape().cgImage // Dynamically generate the particle shape

        particleEmitter.emitterCells = [particle]
        view.layer.addSublayer(particleEmitter)
    }

    /// Creates a particle shape dynamically as a `UIImage`
    private func createParticleShape() -> UIImage {
        let size = CGSize(width: 20, height: 20) // Particle size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }

        // Create a circular shape with gradient
        let colors = [UIColor.white.withAlphaComponent(1.0).cgColor, UIColor.white.withAlphaComponent(0.0).cgColor]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: [0, 1])!
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let radius = size.width / 2

        // Draw a radial gradient circle
        context.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsAfterEndLocation)

        // Get the generated image
        let particleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return particleImage ?? UIImage()
    }

    @objc private func loginTapped() {
        animateButtonTap()
        guard let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(message: "Please fill in both fields")
            return
        }

        if username == "alfagift-admin" && password == "asdf" {
            // Navigate to the next screen
            let studentListVC = StudentListViewController()
            let navigationController = UINavigationController(rootViewController: studentListVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        } else {
            showAlert(message: "Invalid username or password")
        }
    }

    private func animateButtonTap() {
        UIView.animate(withDuration: 0.1,
                       animations: { self.loginButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) },
                       completion: { _ in
                           UIView.animate(withDuration: 0.1) {
                               self.loginButton.transform = .identity
                           }
                       })
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

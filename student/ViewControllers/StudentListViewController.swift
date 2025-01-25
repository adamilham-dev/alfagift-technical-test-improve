//
//  StudentListViewController.swift
//  student
//
//  Created by Adam on 24/01/25.
//

import UIKit

class StudentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var students: [Student] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StudentCell.self, forCellReuseIdentifier: StudentCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        fetchStudentData()
    }

    private func setupUI() {
        setupGradientBackground()
        setupTableView()
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStudentTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]
        title = "Students"
    }

    private func fetchStudentData() {
        students = StudentStorageManager.shared.fetchStudents()
        if students.isEmpty {
            APIManager.shared.fetchStudents { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let apiStudents):
                        self?.students = apiStudents
                        self?.tableView.reloadData()
                    case .failure(let error):
                        self?.showError(error: error)
                    }
                }
            }
        } else {
            tableView.reloadData()
        }
    }
    
    private func showError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    @objc private func addStudentTapped() {
        let addStudentVC = AddStudentViewController()
        addStudentVC.delegate = self
        navigationController?.pushViewController(addStudentVC, animated: true)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as! StudentCell
        let student = students[indexPath.row]
        cell.configure(with: student)
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let studentId = students[indexPath.row].id
            StudentStorageManager.shared.deleteStudent(withId: studentId)
            students.remove(at: indexPath.row) // Remove locally
            tableView.deleteRows(at: [indexPath], with: .fade) // Animate row deletion
        }
    }
}

extension StudentListViewController: AddStudentDelegate {
    func didAddStudent(_ student: Student) {
        StudentStorageManager.shared.addStudent(student)
        students.append(student) // Add locally
        tableView.insertRows(at: [IndexPath(row: students.count - 1, section: 0)], with: .automatic)
    }
}

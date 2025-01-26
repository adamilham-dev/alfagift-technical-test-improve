# Student Management App

This repository contains the **Student Management App**, a mobile application designed for efficient management of student data. Developed as part of a technical test for **Alfagift GLI Academy iOS Developer Intern**, this app provides a user-friendly interface for adding, viewing, updating, and deleting student information, including profile photos. The app also supports offline access by storing student data locally. This app is also an improve version from this project [Github Link](https://github.com/adamilham-dev/alfagift-technical-test-original).

---

## 🚀 Key Features

### 1. **Add Student**
- Input fields for student details: **name**, **email**, **address**, and **avatar**.
- Option to **upload** or **capture a profile photo**.

### 2. **View Students**
- Displays a visually appealing **card-based layout** for student information.
- Each card includes:
  - Profile photo
  - Name
  - Email
  - Address

### 3. **Edit/Delete Student**
- Edit existing student details.
- Delete student data as needed.

### 4. **Local Storage**
- Efficiently stores student data locally using a **custom storage manager** for offline access.

### 5. **Interactive UI**
- Enhanced user experience with:
  - **Gradient backgrounds**
  - **Particle effects**
  - **Dynamic transitions**

---

## 📂 Folder Structure

```plaintext
student.xcodeproj/
├── Controllers/
│   ├── LoginViewController.swift
│   ├── StudentListViewController.swift
│   └── AddStudentViewController.swift
├── Models/
│   ├── Student.swift
│   ├── StudentStorageManager.swift
│   └── APIManager.swift
├── Views/
│   ├── LoginView.xib
│   ├── StudentListView.xib
│   └── AddStudentView.xib
└── Resources/
    ├── Assets.xcassets
    └── Info.plist
```

---

## 🔧 Setup and Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/adamilham-dev/alfagift-technical-test-improve.git
   cd alfagift-technical-test-improve
   ```

2. **Open the project in Xcode**:
   ```bash
   open student.xcodeproj
   ```

3. **Install dependencies (if any)**:
   ```bash
   pod install
   ```

4. **Build and run** the app on a simulator or device.

---

## 📚 Libraries and Frameworks

The app leverages the following tools and technologies:

1. **UIKit**: For building the user interface.
2. **Alamofire**: Simplifies network requests (used for fetching mock API data).
3. **RAGTextField**: Provides modern, animated text fields for user input.
4. **UserDefaults**: Used for local storage of student data.
5. **CAGradientLayer**: Adds visually appealing gradient backgrounds.

---

## 🌐 API Integration

The app uses the **[Reqres API](https://reqres.in/api/users?page=1)** to fetch mock student data. This API allows the app to simulate fetching student information from a server.

---

## 📖 Documentation
- **Reqres API**: [https://reqres.in](https://reqres.in)
- **Alamofire Documentation**: [https://github.com/Alamofire/Alamofire](https://github.com/Alamofire/Alamofire)
- **RAGTextField Documentation**: [https://github.com/Ramotion/input-field](https://github.com/Ramotion/input-field)

For further details, refer to the project documentation:  
[Project Documentation Link](https://drive.google.com/file/d/1uxhpsL3QJ1qO9aS4eO8tvOOOOOSr4ZYO/view?usp=sharing)

---

## 🎥 Video Demo

Check out the video demonstration of the app:
[Watch Demo](https://drive.google.com/file/d/14qrfSzLXUARnk3y2KWSZzXjtXStB_0ZU/view?usp=sharing)

---

## 🛠 Future Improvements
- Add authentication with real back-end integration.
- Implement pagination for the student list.
- Enhance profile photo editing with cropping and filtering options.
- Add unit tests for core components like `StudentStorageManager` and `APIManager`.

---

## 🤝 Acknowledgments
- **Alfagift GLI Academy** for the opportunity to develop this project.
- Developers and maintainers of the libraries and frameworks used in this project.

Thank you for checking out this project! If you have any feedback or suggestions, feel free to open an issue or contact this [email](adamilham3004@gmail.com).



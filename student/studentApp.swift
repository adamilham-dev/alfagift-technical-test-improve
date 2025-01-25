//
//  studentApp.swift
//  student
//
//  Created by Adam on 24/01/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        LoginViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}

struct LoginViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }

    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        // Leave empty as we don't need to update anything for now
    }
}

@main
struct studentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

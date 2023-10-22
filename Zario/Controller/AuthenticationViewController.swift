//
//  AuthenticationViewController.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import UIKit
import LocalAuthentication

final class AuthenticationViewController: UIViewController {

    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Unlock app".localized()
        configuration.titleAlignment = .center
        configuration.titlePadding = 4
        configuration.baseForegroundColor = .systemBlue

        let systemName = {
            switch AuthenticationViewController.biometryType {
            case .faceID:
                return "faceid"
            case .touchID:
                return "touchid"
            default:
                return "lock.circle"
            }
        }()
        configuration.image = UIImage(systemName: systemName)
        configuration.imagePadding = 4

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(authenticate), for: .touchUpInside)

        return button
    }()

    private lazy var customConstraints: [NSLayoutConstraint] = {
        [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9),
            button.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.4)
        ]
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        authenticate()
    }

    private func addSubviews() {
        view.addSubview(button)
        NSLayoutConstraint.activate(customConstraints)
    }

    @objc private func authenticate() {
        let context = LAContext()

        let authenticationClosure: (LAPolicy) -> Bool = { policy in
            let answer = context.canEvaluatePolicy(policy, error: nil)

            defer {
                if answer {
                    let reason = "Authenticate your identity to use the app".localized()
                    context.evaluatePolicy(policy, localizedReason: reason) { [weak self] value, error in
                        guard let self = self else {
                            return
                        }
                        if let error = error {
                            if (error as? LAError)?.code != .userCancel {
                                DispatchQueue.main.async { self.showError(error) }
                            }
                        } else {
                            DispatchQueue.main.async { self.navigationController?.viewControllers = [MainViewController()] }
                        }
                    }
                }
            }

            return answer
        }

        if !authenticationClosure(.deviceOwnerAuthenticationWithBiometrics) &&
            !authenticationClosure(.deviceOwnerAuthentication) {
            showError(NSError(domain: "Authentication unavailable".localized(), code: Int(errSecAuthFailed)))
        }
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Whoops!".localized(),
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized(), style: .default))
        present(alert, animated: true)
    }

    private static var biometryType: LABiometryType = {
        let context = LAContext()
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }()
}

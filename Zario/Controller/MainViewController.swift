//
//  ViewController.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import UIKit

class MainViewController: UIViewController {
    
    let screenTimeModel = ScreenTimeModel()
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showSettings))
        
        return button
    }()
    
    private lazy var restrictAppButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Restrict apps".localized()
        configuration.titleAlignment = .center
        configuration.titlePadding = 4
        configuration.baseForegroundColor = .systemBlue

        
        configuration.image = UIImage(systemName: "hand.raised.brakesignal")
        configuration.imagePadding = 4
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(selectApps), for: .touchUpInside)
        
        return button
    }()
    private lazy var preventInstallAppButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Prevent installation of apps".localized()
        configuration.titleAlignment = .center
        configuration.titlePadding = 4
        configuration.baseForegroundColor = .systemBlue

        
        configuration.image = UIImage(systemName: "nosign.app")
        configuration.imagePadding = 4
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(preventAppInstall), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var customConstraints: [NSLayoutConstraint] = [
        restrictAppButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        restrictAppButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        preventInstallAppButton.centerXAnchor.constraint(equalTo: restrictAppButton.centerXAnchor),
        preventInstallAppButton.topAnchor.constraint(equalTo: restrictAppButton.bottomAnchor, constant: 10)
    ]
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Zario"
    }
    
    private func addSubviews() {
        view.addSubview(restrictAppButton)
        view.addSubview(preventInstallAppButton)
        NSLayoutConstraint.activate(customConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupNavigationBar()
        addSubviews()
        
        ZarioSettings.shared.requestScreenTimeAuthorizationOn(self)
    }
    
    @objc private func showSettings() {
        present(SettingsViewController(), animated: true)
    }
    
    @objc private func selectApps() {
        restrictAppButton.isUserInteractionEnabled = false
        ZarioSettings.shared.requestScreenTimeAuthorizationOn(self, completionHandler: { [weak self] success in
            self?.restrictAppButton.isUserInteractionEnabled = true
            
            guard success,
                  let self = self else { return }
            let vc = ScreenTimeSelectionView(model: self.screenTimeModel).bridgingToUIViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    @objc private func preventAppInstall() {
        screenTimeModel.toggleAppInstall()
    }
}


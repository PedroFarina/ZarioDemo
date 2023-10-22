//
//  SceneDelegate.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        

        let navController: UINavigationController
        if ZarioSettings().getValueFor(.faceID) {
            navController = UINavigationController(rootViewController: AuthenticationViewController())
        } else {
            navController = UINavigationController(rootViewController: MainViewController())
        }
        window?.rootViewController = navController

        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}


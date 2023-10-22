//
//  UIViewController+Extension.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import UIKit

extension UIViewController {
    func showErrorFeedback(_ error: Error) {
        let alertController = UIAlertController(title: "Whoops".localized(), message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok".localized(), style: .default))
        present(alertController, animated: true)
    }
}

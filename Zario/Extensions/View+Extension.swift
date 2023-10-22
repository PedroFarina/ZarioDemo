//
//  View+Extension.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import SwiftUI

extension View {
    func bridgingToUIViewController() -> UIViewController {
        let viewController = UIViewController()
        let hostingController = UIHostingController(rootView: self)
        viewController.addChild(hostingController)
        viewController.view.addSubview(hostingController.view)
        hostingController.view.frame = viewController.view.frame
        hostingController.didMove(toParent: viewController)
        
        return viewController
    }
}

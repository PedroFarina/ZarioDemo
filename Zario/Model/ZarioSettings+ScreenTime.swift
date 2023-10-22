//
//  ZarioSettings + Extension.swift
//  Zario
//
//  Created by Pedro Farina on 10/22/23.
//

import UIKit
import FamilyControls

// As the ZarioSettings is being shared with all targets, this extends only targetting the app itself.
// This should not be used as is, and we should have a separate target only to handle database information.
extension ZarioSettings {
    func requestScreenTimeAuthorization() async throws {
        try await authorizationCenter.requestAuthorization(for: .individual)
    }
    
    func requestScreenTimeAuthorizationOn(_ vc: UIViewController, completionHandler: ((Bool) -> Void)? = nil) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                try await self.requestScreenTimeAuthorization()
                completionHandler?(true)
            } catch {
                vc.showErrorFeedback(error)
                completionHandler?(false)
            }
        }
    }
}

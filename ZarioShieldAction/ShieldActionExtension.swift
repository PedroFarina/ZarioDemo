//
//  ShieldActionExtension.swift
//  ZarioShieldAction
//
//  Created by Pedro Farina on 10/22/23.
//

import Foundation
import ManagedSettings

class ShieldActionExtension: ShieldActionDelegate {
    
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
            let store = ManagedSettingsStore()
            store.shield.applications?.remove(application)
            // Retrieve the time and add either a DeviceActivity to trigger in such a time or another way of triggering this piece
            // of code in background/with the app closed. Maybe via Shortcuts?
            DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
                store.shield.applications?.insert(application)
            }
            
            completionHandler(.none)
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        completionHandler(.close)
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        completionHandler(.close)
    }
}

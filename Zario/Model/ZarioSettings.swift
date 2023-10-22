//
//  ZarioSettings.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import Foundation
import FamilyControls
import ManagedSettings

final class ZarioSettings {
    
    static var shared: ZarioSettings = ZarioSettings()
    
    // Those are internal constants so in a different environment we could inject a different protocol and test them
    // but as this is a fast project I've decided to use the concrete type with UserDefaults.
    let userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.PGF.Zario") ?? .standard
    let authorizationCenter: AuthorizationCenter = .shared
    
    enum Key: String, CaseIterable {
        case faceID
        case partialBlock
        
        var title: String {
            switch self {
            case .faceID:
                return "Require Authentication to open app"
            case .partialBlock:
                return "Allow 10 seconds to use apps"
            }
        }
    }
    
    func getValueFor(_ key: Key) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }
    func setValueFor(_ key: Key, value: Bool) {
        userDefaults.set(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
    
    // Using the hashvalue of the token as UserDefaults is a bit limited. When actually implementing it, should be done
    // via a functioning database such as SwiftData, CoreData or Realm and encoding the token itself then decoding it.
    func incrementApplicationOpenValue(_ application: ApplicationToken) {
        let currentTimes = getTimesAppWasOpened(application)
        userDefaults.set(currentTimes + 1, forKey: String(application.hashValue))
    }
    func getTimesAppWasOpened(_ application: ApplicationToken) -> Int {
        userDefaults.integer(forKey: String(application.hashValue))
    }
}

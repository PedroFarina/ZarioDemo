//
//  ShieldConfigurationExtension.swift
//  ZarioShieldConfiguration
//
//  Created by Pedro Farina on 10/22/23.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        guard let token = application.token else { return ShieldConfiguration() }
        
        let secondaryButtonLabel: ShieldConfiguration.Label?
        if ZarioSettings.shared.getValueFor(.partialBlock) {
            secondaryButtonLabel = ShieldConfiguration.Label(text: "Ignore for 10 seconds".localized(), color: .tertiaryLabel)
        } else {
            secondaryButtonLabel = nil
        }
        
        // This function gets called twice sometimes (when entering/leaving the app), this would need to be taken into consideration
        ZarioSettings.shared.incrementApplicationOpenValue(token)
        let subtitle = "You have chosen to block this app, but so far you opened it ".localized() +
                       String(ZarioSettings.shared.getTimesAppWasOpened(token)) + " times".localized()
        
        return ShieldConfiguration(backgroundBlurStyle: .extraLight,
                                   backgroundColor: #colorLiteral(red: 0.3966889083, green: 0.4237087369, blue: 0.8840052485, alpha: 1),
                                   icon: UIImage(named: "Zario"),
                                   title: ShieldConfiguration.Label(text: "Zario Blocker".localized(), color: .label),
                                   subtitle: ShieldConfiguration.Label(text: subtitle, color: .secondaryLabel),
                                   primaryButtonLabel: ShieldConfiguration.Label(text: "Close".localized(), color: .white),
                                   primaryButtonBackgroundColor: #colorLiteral(red: 0.9098039216, green: 0.6862745098, blue: 0.6196078431, alpha: 1),
                                   secondaryButtonLabel: secondaryButtonLabel)
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        ShieldConfiguration()
    }
}

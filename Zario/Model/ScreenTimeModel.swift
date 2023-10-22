//
//  ScreenTimeModel.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import Combine
import FamilyControls
import ManagedSettings

final class ScreenTimeModel: ObservableObject {
    
    private let store = ManagedSettingsStore()
    private var cancellables: Set<AnyCancellable> = []
    @Published var activitySelection = FamilyActivitySelection()
    private var blockAppInstall: Bool = false
    
    init() {
        store.clearAllSettings()
        $activitySelection.sink { [weak self] _ in
            self?.restrictApps()
        }.store(in: &cancellables)
    }
    
    func restrictApps() {
        store.shield.applications = activitySelection.applicationTokens
    }
    
    func toggleAppInstall() {
        blockAppInstall.toggle()
        store.application.denyAppInstallation = blockAppInstall
    }
}

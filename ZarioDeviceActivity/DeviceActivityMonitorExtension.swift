//
//  DeviceActivityMonitorExtension.swift
//  ZarioDeviceActivity
//
//  Created by Pedro Farina on 10/22/23.
//

import DeviceActivity

class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
    }
    
    
    // In theory this function should be called only when the selected event/application has been used for
    // a pre-defined time. For some reason it's triggering immediatly when starting to monitor. This should
    // be fixed soon by Apple, but anyhow I do have some engineer contacts at Apple to reach out to support our usage
    // https://developer.apple.com/forums/thread/728277
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
    }
}

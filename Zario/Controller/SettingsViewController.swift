//
//  SettingsViewController.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import UIKit

final class SettingsViewController: UITableViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ZarioSettings.Key.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = ZarioSettings.Key.allCases[indexPath.row]
        
        let switchView = UISwitch(frame: .zero, primaryAction: UIAction() { action in
            guard let switchView = action.sender as? UISwitch else { return }
            ZarioSettings.shared.setValueFor(key, value: switchView.isOn)
        })
        switchView.isOn = ZarioSettings.shared.getValueFor(key)
        
        let cell = UITableViewCell(frame: .zero)
        var config = cell.defaultContentConfiguration()
        config.directionalLayoutMargins = .init(top: 0, leading: 20, bottom: 0, trailing: 0)
        config.text = key.title.localized()

        cell.accessoryView = switchView

        cell.contentConfiguration = config

        return cell
    }
}

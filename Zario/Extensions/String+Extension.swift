//
//  String+Extension.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}

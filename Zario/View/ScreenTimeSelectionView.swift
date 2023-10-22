//
//  ScreenTimeSelectionView.swift
//  Zario
//
//  Created by Pedro Farina on 10/21/23.
//

import SwiftUI
import FamilyControls

struct ScreenTimeSelectionView: View {

    @ObservedObject var model: ScreenTimeModel

    var body: some View {
        FamilyActivityPicker(selection: $model.activitySelection)
    }
}

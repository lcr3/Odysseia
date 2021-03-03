//
//  MockSetting.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/20.
//

@testable import Odysseia

class MockSettingView: SettingView {
    var presenter: SettingPresentation!
    var callCountViewDidLoad = 0

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }
}

class MockSettingPresenter: SettingPresentation {
    var callCountCellTouched = 0
    var callCountGetItems = 0
    var callCountDismissButtonTouched = 0

    var cellTouchedRow: SettingRow?

    func cellTouched(row: SettingRow) {
        callCountCellTouched += 1
        cellTouchedRow = row
    }

    func getItems() -> [SettingItem] {
        callCountGetItems += 1
        return []
    }

    func dismissButtonTouched() {
        callCountDismissButtonTouched += 1
    }
}

class MockSettingRouter: SettingWireframe {
    var callCountDismiss = 0
    var callCountShowAbout = 0
    var callCountShowSupport = 0
    var callCountShowSourceCode = 0

    func dismiss() {
        callCountDismiss += 1
    }

    func showAbout() {
        callCountShowAbout += 1
    }

    func showSupport() {
        callCountShowSupport += 1
    }

    func showSourceCode() {
        callCountShowSourceCode += 1
    }
}

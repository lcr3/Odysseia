//
//  MockSettingAbout.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/21.
//

@testable import Odysseia
import Foundation

class MockSettingAboutView: SettingAboutView {
    var presenter: SettingAboutPresentation!
    var callCountSet = 0
    var set: String = ""

    func set(version: String) {
        callCountSet += 1
        set = version
    }
}

class MockSettingAboutPresenter: SettingAboutPresentation {
    var callCountViewDidLoad = 0
    var callCountGetItems = 0
    var callCountCallTouched = 0
    var items = SettingAboutPresenter.createItems()
    var version = ""
    var row: Int?

    func viewDidLoad() {
        callCountViewDidLoad += 1
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return
        }
        self.version = version
    }

    func getItems() -> [SettingAboutItem] {
        callCountGetItems += 1
        return items
    }

    func cellTouched(row: Int) {
        callCountCallTouched += 1
        self.row = row
    }
}

class MockSettingAboutRouter: SettingAboutWireframe {
    var callCountShowWeb = 0
    var url: URL?

    func showWeb(url: URL) {
        callCountShowWeb += 1
        self.url = url
    }
}

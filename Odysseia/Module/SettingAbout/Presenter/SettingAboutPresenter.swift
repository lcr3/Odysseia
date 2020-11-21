//
//  SettingAboutPresenter.swift
//  Odysseia
//
//  Created by lcr on 20/11/2020.
//
import  UIKit
protocol SettingAboutPresentation: AnyObject {
    // View -> Presenter
    func viewDidLoad()
    func getItems() -> [SettingAboutItem]
    func cellTouched(row: Int)
}

class SettingAboutPresenter {
    private weak var view: SettingAboutView?
    private let router: SettingAboutWireframe
    private let items: [SettingAboutItem]

    init(view: SettingAboutView,
         router: SettingAboutWireframe) {
        self.view = view
        self.router = router
        items = SettingAboutPresenter.createItems()
    }

    static func createItems() -> [SettingAboutItem] {
        [SettingAboutItem(title: L10n.Localizable.hgCircularSliderTitle,
                          link: L10n.Localizable.hgCircularSliderLink)]
    }
}

extension SettingAboutPresenter: SettingAboutPresentation {
    func viewDidLoad() {
        guard let number = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return
        }
        view?.set(version: "Version " + number)
    }

    func getItems() -> [SettingAboutItem] {
        items
    }

    func cellTouched(row: Int) {
        let item = items[row]
        guard let url = URL(string: item.link) else { return }
        router.showWeb(url: url)
    }
}

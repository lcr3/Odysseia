//
//  SettingPresenter.swift
//  Odysseia
//
//  Created by lcr on 19/11/2020.
//

protocol SettingPresentation: AnyObject {
    // View -> Presenter
    func cellTouched(row: SettingRow)
    func getItems() -> [SettingItem]
    func dismissButtonTouched()
}

class SettingPresenter {
    private weak var view: SettingView?
    private let router: SettingWireframe
    private let items: [SettingItem]

    init(view: SettingView,
         router: SettingWireframe) {
        self.view = view
        self.router = router
        items = SettingPresenter.createItems()
    }

    static func createItems() -> [SettingItem] {
        [SettingItem(title: L10n.Localizable.aboutTitle, image: #imageLiteral(resourceName: "ic_mercury"), row: .about),
         SettingItem(title: L10n.Localizable.supportTitle, image: #imageLiteral(resourceName: "ic_venus"), row: .support),
         SettingItem(title: L10n.Localizable.sourceTitle, image: #imageLiteral(resourceName: "ic_earth"), row: .source)]
    }
}

extension SettingPresenter: SettingPresentation {
    func cellTouched(row: SettingRow) {
        switch row {
        case .about:
            router.showAbout()
        case .support:
            router.showSupport()
        case .source:
            router.showSourceCord()
        }
    }

    func getItems() -> [SettingItem] {
        items
    }

    func dismissButtonTouched() {
        router.dismiss()
    }
}

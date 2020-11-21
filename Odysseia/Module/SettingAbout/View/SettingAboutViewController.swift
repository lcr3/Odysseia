//
//  SettingAboutViewController.swift
//  Odysseia
//
//  Created by lcr on 20/11/2020.
//

import UIKit

protocol SettingAboutView: AnyObject {
    var presenter: SettingAboutPresentation! { get }
    // View -> Presenter
    func set(version: String)
}

class SettingAboutViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: SettingAboutPresentation!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
}

extension SettingAboutViewController: SettingAboutView {
    func set(version: String) {
        versionLabel.text = version
    }
}

extension SettingAboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        presenter.cellTouched(row: indexPath.row)
    }
}

extension SettingAboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getItems().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aboutCell = tableView.dequeueReusableCell(withIdentifier: SettingAboutCell.className) as? SettingAboutCell else {
            return UITableViewCell()
        }
        let item = presenter.getItems()[indexPath.row]
        aboutCell.setCell(item: item)
        return aboutCell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "ACKNOWLEDGMENTS"
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "COPYRIGHT © 2020 LCR"
    }
}

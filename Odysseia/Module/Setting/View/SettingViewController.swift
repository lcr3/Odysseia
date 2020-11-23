//
//  SettingViewController.swift
//  Odysseia
//
//  Created by lcr on 19/11/2020.
//

import UIKit

enum SettingRow: Int {
    case about
    case support
    case source

    init(row: Int) {
        if row == SettingRow.about.rawValue {
            self = .about
        } else if row == SettingRow.support.rawValue {
            self = .support
        } else {
            self = .source
        }
    }
}

protocol SettingView: AnyObject {
    var presenter: SettingPresentation! { get }
    // View -> Presenter
    func viewDidLoad()
}

class SettingViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: SettingPresentation!

    @IBOutlet weak var tableView: UITableView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.backgroundColor = .clear
        setNavigationButtons()
    }

    private func setNavigationButtons() {
        let dismissBarItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(dismissButtonTouched(_:)))
        navigationItem.leftBarButtonItems = [dismissBarItem]
    }

    @objc private func dismissButtonTouched(_ sender: UIBarButtonItem) {
        presenter.dismissButtonTouched()
    }
}

extension SettingViewController: SettingView {
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getItems().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.className) as? SettingCell else {
            return UITableViewCell()
        }
        let item = presenter.getItems()[indexPath.row]
        settingCell.setCell(item: item)

        return settingCell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        presenter.cellTouched(row: SettingRow(row: indexPath.row))
    }
}

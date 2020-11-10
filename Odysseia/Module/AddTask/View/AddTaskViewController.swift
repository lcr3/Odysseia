//
//  AddTaskViewController.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import UIKit

enum TaskSection: Int, CaseIterable {
    case task
}

protocol AddTaskView: AnyObject {
    var presenter: AddTaskPresentation! { get }
    // Presenter -> View
    func reload(tasks: [TemporaryTask])
    func validationError(msg: String)
    func showDeleteAlert(row: Int)
}

class AddTaskViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: AddTaskPresentation!

    @IBOutlet weak var collectionView: UICollectionView!

    private let collectionViewMargin: CGFloat = 16
    private let collectionViewInset = UIEdgeInsets(top: 10, left: 2.0, bottom: 2.0, right: 2.0)
    private lazy var dataSource: UICollectionViewDiffableDataSource<TaskSection, TemporaryTask> = {
        let dataSouce = UICollectionViewDiffableDataSource<TaskSection, TemporaryTask>(collectionView: collectionView) { collectionView, indexPath, task -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddTaskCell.className, for: indexPath) as? AddTaskCell {
                cell.setCell(task: task)
                return cell
            }
            return UICollectionViewCell()
        }
        return dataSouce
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }

    @IBAction func addTaskButtonTouched(_ sender: Any) {
        presenter.addTaskButtonTouched()
    }

    @IBAction func addGoalButtonTouched(_ sender: Any) {
        presenter.doneButtonTouched()
    }

    @IBAction func backButtonTouched(_ sender: Any) {
        presenter.backButtonTouched()
    }
}

extension AddTaskViewController: AddTaskView {
    func reload(tasks: [TemporaryTask]) {
        var snapshot = NSDiffableDataSourceSnapshot<TaskSection, TemporaryTask>()
        snapshot.appendSections(TaskSection.allCases)
        snapshot.appendItems(tasks, toSection: .task)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func validationError(msg: String) {
        let alert = UIAlertController.errorAlert(msg: msg)
        present(alert, animated: true)
    }

    func showDeleteAlert(row: Int) {
        let alert = UIAlertController(title: nil,
                                      message: L10n.Localizable.addTaskDeleteMsg,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.Localizable.delete,
                                      style: .destructive) { _ in
            self.presenter.deleteButtonTouched(row: row)
        })
        alert.addAction(UIAlertAction(title: L10n.Localizable.cancel,
                                      style: .cancel))
        present(alert, animated: true)
    }
}

extension AddTaskViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.taskCellTouched(row: indexPath.row)
    }
}

extension AddTaskViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.tasks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddTaskCell.className, for: indexPath) as? AddTaskCell {
            cell.setCell(task: presenter.tasks[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension AddTaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionViewMargin
        return CGSize(width: width, height: AddTaskCell.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionViewInset
    }
}

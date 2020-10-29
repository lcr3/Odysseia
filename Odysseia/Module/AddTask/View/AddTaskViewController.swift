//
//  AddTaskViewController.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import UIKit
import BottomHalfModal

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
    @IBOutlet weak var nextButton: UIButton!

    private let collectionCellHeight: CGFloat = 110
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        presenter.loadGoals()
    }

    @IBAction func addTaskButtonTouched(_ sender: Any) {
        let vc = TaskInputModalViewController(delegate: self)
        let nav = BottomHalfModalNavigationController(rootViewController: vc)
        presentBottomHalfModal(nav, animated: true, completion: nil)

    }
    @IBAction func nextButtonTouched(_ sender: Any) {
        presenter.doneButtonTouched()
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
        return CGSize(width: width, height: collectionCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionViewInset
    }
}

extension AddTaskViewController: TaskInputDelegate {
    func scceseAdd(title: String, targetLevel: Int) {
        presenter.addNewTask(title: title, targetLevel: targetLevel)
    }
}

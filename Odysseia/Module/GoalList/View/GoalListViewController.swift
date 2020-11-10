//
//  GoalListViewController.swift
//  OdysseiaTest
//
//  Created by lcr on 2020/10/19.
//

import UIKit

final class GoalListSectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

enum GoalSection: Int, CaseIterable {
    case goal
}

protocol GoalListView: AnyObject {
    var presenter: GoalListPresentation! { get }
    // Prensenter -> View
    func viewDidLoad()
    func reload(goals: [Goal])
    func showErrorMessageView(reason: String)
}

class GoalListViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: GoalListPresentation!
    private let collectionCellHeight: CGFloat = 110
    private let collectionViewMargin: CGFloat = 16
    private lazy var dataSource: UICollectionViewDiffableDataSource<GoalSection, Goal> = {
        let dataSouce = UICollectionViewDiffableDataSource<GoalSection, Goal>(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalListCollectionCell.className, for: indexPath) as? GoalListCollectionCell {
                cell.setCell(goal: item)
                return cell
            }
            return UICollectionViewCell()
        }
        return dataSouce
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self

        // TODO リファクタ
        let addBarItem = UIBarButtonItem(title: L10n.Localizable.addButtonText, style: .done, target: self, action: #selector(addBarButtonTapped(_:)))
        addBarItem.image = UIImage(systemName: "plus")

        navigationItem.rightBarButtonItems = [addBarItem]

        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GoalListSectionHeader.className, for: indexPath) as? GoalListSectionHeader else {
                    fatalError("")
                }
                return header
            }
            return UICollectionReusableView()
        }
        let logPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPress))
        collectionView.addGestureRecognizer(logPressGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadGoals()
    }

    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        presenter.addButtonTouched()
    }

    @objc func cellLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state != .ended { return }
        let pressPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: pressPoint) else { return }
        // TODO showdeletealert
    }
}

extension GoalListViewController: GoalListView {
    func reload(goals: [Goal]) {
        var snapshot = NSDiffableDataSourceSnapshot<GoalSection, Goal>()
        snapshot.appendSections(GoalSection.allCases)
        snapshot.appendItems(goals, toSection: .goal)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func showErrorMessageView(reason: String) {
        // todo show error message
    }
}

extension GoalListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goalCellTouched(row: indexPath.row)
    }
}

extension GoalListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.goals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalListCollectionCell.className, for: indexPath) as? GoalListCollectionCell {
            cell.titleLabel.text = presenter.goals[indexPath.item].title
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GoalListSectionHeader.className, for: indexPath) as? GoalListSectionHeader else {
            fatalError("Could not find proper header")
        }

        if kind == UICollectionView.elementKindSectionHeader {
            header.sectionLabel.text = "section \(indexPath.section)"
            return header
        }

        return UICollectionReusableView()
    }
}

extension GoalListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionViewMargin
        return CGSize(width: width, height: collectionCellHeight)
    }
}

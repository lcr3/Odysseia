//
//  GoalListTutorialViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/11/22.
//

import Gecco
import UIKit

class GoalListTutorialViewController: SpotlightViewController {
    lazy var geccoSpotlight = Spotlight.Oval(center: CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 200 + view.safeAreaInsets.top), diameter: 220)

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func start() {
        let rightBarButtonFrames = extractRightBarButtonConvertedFrames()
        view.addSubview(createAnnotationView())
        spotlightView.appear(Spotlight.Oval(center: CGPoint(x: rightBarButtonFrames.midX, y: rightBarButtonFrames.midY), diameter: 50))
    }

    private func createAnnotationView() -> UILabel {
        let navigationBarHeight: CGFloat = 64
        let margin: CGFloat = 16
        let annotationView = UILabel(frame: CGRect(x: 0, y: navigationBarHeight + margin, width: view.frame.width - margin, height: 80))
        annotationView.text = L10n.Localizable.goalListTutorialMsg
        annotationView.textAlignment = .right
        annotationView.textColor = .white
        return annotationView
    }
}

private extension GoalListTutorialViewController {
    var viewControllerHasNavigationItem: UIViewController? {
        if let navigationController = presentingViewController as? UINavigationController {
            return navigationController.viewControllers[0]
        }
        return presentingViewController
    }

    func extractRightBarButtonConvertedFrames() -> CGRect {
        guard
            let firstRightBarButtonItem = viewControllerHasNavigationItem?.navigationItem.rightBarButtonItems?[0].value(forKey: "view") as? UIView
        else {
            fatalError("Unexpected extract view from UIBarButtonItem via value(forKey:)")
        }
        return firstRightBarButtonItem.convert(firstRightBarButtonItem.bounds, to: view)

    }
}

extension GoalListTutorialViewController: SpotlightViewControllerDelegate {
    func spotlightViewControllerWillPresent(_ viewController: SpotlightViewController, animated: Bool) {
        start()
    }

    func spotlightViewControllerTapped(_ viewController: SpotlightViewController, tappedSpotlight: SpotlightType?) {
        dismiss(animated: true, completion: nil)
    }

    func spotlightViewControllerWillDismiss(_ viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
}

//
//  AddTaskTutorialViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/11/23.
//

import Gecco
import UIKit

class AddTaskTutorialViewController: SpotlightViewController {
    lazy var geccoSpotlight = Spotlight.Oval(center: CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 200 + view.safeAreaInsets.top), diameter: 220)

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func start(frame: CGRect) {
        view.addSubview(createAnnotationView())
        spotlightView.appear(Spotlight.Oval(center: CGPoint(x: frame.midX, y: frame.midY), diameter: 50))
    }

    private func createAnnotationView() -> UILabel {
        let navigationBarHeight: CGFloat = 64
        let margin: CGFloat = 16
        let annotationView = UILabel(frame: CGRect(x: 0, y: navigationBarHeight + margin, width: view.frame.width - margin, height: 80))
        annotationView.text = L10n.Localizable.addTaskTutorialMsg
        annotationView.textAlignment = .right
        annotationView.textColor = .white
        return annotationView
    }
}

extension AddTaskTutorialViewController: SpotlightViewControllerDelegate {
    func spotlightViewControllerWillPresent(_ viewController: SpotlightViewController, animated: Bool) {
        //        start()
    }

    func spotlightViewControllerTapped(_ viewController: SpotlightViewController, tappedSpotlight: SpotlightType?) {
        dismiss(animated: true, completion: nil)
    }

    func spotlightViewControllerWillDismiss(_ viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
}

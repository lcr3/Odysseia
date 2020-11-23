//
//  TutorialViewController.swift
//  Odysseia
//
//  Created by lcr on 14/11/2020.
//

import SceneKit
import UIKit

protocol TutorialView: AnyObject {
    var presenter: TutorialPresentation! { get }
}

class TutorialViewController: UIPageViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: TutorialPresentation!
    var pageControll = TutorialPageControll()
    var pages: [UIViewController] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        let starView = StarView.make()
        view.addSubview(starView)
        starView.startAnimation()

        view.backgroundColor = Asset.astro.color
        pages = [getFirst(), getSecond(), getThird()]
        pageControll.frame = CGRect(x: 0,
                                    y: UIScreen.main.bounds.height - TutorialPageControll.height * 2,
                                    width: UIScreen.main.bounds.width,
                                    height: TutorialPageControll.height)
        pageControll.numberOfPages = pages.count
        view.addSubview(pageControll)

        guard let firstPage = pages.first else { return }
        self.setViewControllers([firstPage],
                                direction: .forward,
                                animated: true,
                                completion: nil)
    }

    private func getFirst() -> FirstViewController {
        guard let sb = storyboard, let vc = sb.instantiateViewController(withIdentifier: FirstViewController.className) as? FirstViewController else {
            fatalError("Faild load FirstViewController")
        }
        return vc
    }

    private func getSecond() -> SecondViewController {
        guard let sb = storyboard, let vc = sb.instantiateViewController(withIdentifier: SecondViewController.className) as? SecondViewController else {
            fatalError("Faild load SecondViewController")
        }
        return vc
    }

    private func getThird() -> ThirdViewController {
        guard let sb = storyboard, let vc = sb.instantiateViewController(withIdentifier: ThirdViewController.className) as? ThirdViewController else {
            fatalError("Faild load ThirdViewController")
        }
        vc.delegate = self
        return vc
    }
}

extension TutorialViewController: TutorialView {
}

extension TutorialViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index > 0 {
            return pages[index - 1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index < pages.count - 1 {
            return pages[index + 1]
        }
        return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        0
    }
}

extension TutorialViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed { return }
        if pageViewController.viewControllers?.first is FirstViewController {
            pageControll.currentPage = 0
        } else if pageViewController.viewControllers?.first is SecondViewController {
            pageControll.currentPage = 1
        } else {
            pageControll.currentPage = 2
        }
    }
}

extension TutorialViewController: ThirdViewControllerDelegate {
    func startButtonTouched() {
        presenter.startButtonTouched()
    }
}

//
//  TaskInputPresenter.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

protocol TaskInputPresentation: AnyObject {
    // View -> Presenter
    func viewDidLoad()
    func incrementButtonTouched()
    func decrementButtonTouched()
    func addTaskButtonTouched(title: String?)
    func cancelButtonTouched()
}

class TaskInputPresenter {
    private weak var view: TaskInputView?
    private let router: TaskInputWireframe
    private weak var output: TaskInputPresenterOutput?
    private var targetCount: Int

    init(view: TaskInputView,
         router: TaskInputWireframe,
         output: TaskInputPresenterOutput) {
        self.view = view
        self.router = router
        self.output = output
        targetCount = Task.minTargetCount
    }
}

extension TaskInputPresenter: TaskInputPresentation {
    func viewDidLoad() {
        view?.setTargetCount(text: "\(targetCount)")
    }

    func incrementButtonTouched() {
        if targetCount >= Task.maxTargetCount {
            return
        }
        targetCount += 1
        view?.setTargetCount(text: "\(targetCount)")
    }

    func decrementButtonTouched() {
        if targetCount <= Task.minTargetCount {
            return
        }
        targetCount -= 1
        view?.setTargetCount(text: "\(targetCount)")
    }

    func cancelButtonTouched() {
        output = nil
        router.dismiss()
    }

    func addTaskButtonTouched(title: String?) {
        guard let title = title else {
            view?.showErrorAlert(msg: L10n.Localizable.addTaskTitleNilMsg)
            return
        }
        output?.successAddTask(title: title, targetLevel: targetCount)
        output = nil
        router.dismiss()
    }
}

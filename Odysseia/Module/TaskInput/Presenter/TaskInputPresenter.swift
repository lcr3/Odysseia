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
    func addTaskButtonTouched()
    func cancelButtonTouched()
    func updateTitle(title: String)
}

class TaskInputPresenter {
    private weak var view: TaskInputView?
    private let router: TaskInputWireframe
    private weak var output: TaskInputPresenterOutput?

    private var taskTitle: String
    private var targetCount: Int

    init(view: TaskInputView,
         router: TaskInputWireframe,
         output: TaskInputPresenterOutput) {
        self.view = view
        self.router = router
        self.output = output
        taskTitle = ""
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

    func updateTitle(title: String) {
        taskTitle = title
    }

    func cancelButtonTouched() {
        output = nil
        router.dismiss()
    }

    func addTaskButtonTouched() {
        if taskTitle.isEmpty {
            view?.showErrorAlert(msg: L10n.Localizable.addTaskTitleNilMsg)
            return
        }
        output?.successAddTask(title: taskTitle, targetLevel: targetCount)
        output = nil
        router.dismiss()
    }
}

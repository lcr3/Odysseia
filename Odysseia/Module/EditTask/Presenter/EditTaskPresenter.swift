//
//  EditTaskPresenter.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

protocol EditTaskPresentation: AnyObject {
    var task: Task { get }

    // View -> Presenter
    func viewDidLoad()
    func incrementButtonTouched()
    func decrementButtonTouched()
    func doneButtonTouched()
}

class EditTaskPresenter {
    private weak var view: EditTaskView?
    private let router: EditTaskWireframe
    private let interactor: EditTaskUsecase
    private weak var output: EditTaskPresenterOutput?

    let task: Task
    var editTitle: String
    var editReachCount: Int
    var editTargetCount: Int

    init(view: EditTaskView,
         router: EditTaskWireframe,
         interactor: EditTaskUsecase,
         task: Task,
         output: EditTaskPresenterOutput) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.task = task
        self.output = output
        editTitle = task.title
        editReachCount = Int(task.reachCount)
        editTargetCount = Int(task.targetCount)
    }
}

extension EditTaskPresenter: EditTaskPresentation {
    func viewDidLoad() {
        view?.setReachCount(text: "\(editReachCount) / \(editTargetCount)")
    }

    func incrementButtonTouched() {
        if editTargetCount <= editReachCount {
            return
        }
        editReachCount += 1
        view?.setReachCount(text: "\(editReachCount) / \(editTargetCount)")
    }

    func decrementButtonTouched() {
        if editReachCount <= 0 {
            return
        }
        editReachCount -= 1
        view?.setReachCount(text: "\(editReachCount) / \(editTargetCount)")
    }

    func doneButtonTouched() {
        task.title = editTitle
        task.reachCount = Int16(editReachCount)
        task.targetCount = Int16(editTargetCount)
        interactor.update(task: task)
    }
}

extension EditTaskPresenter: EditTaskInteractorOutput {
    func sccessUpdate(task: Task) {
        router.dismiss()
        output?.successUpdete(task: task)
    }

    func faildUpdate(msg: String) {
        view?.showErrorAlert(msg: msg)
    }
}

//
//  AddTaskPresenter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

protocol AddTaskPresentation: AnyObject {
    var tasks: [TemporaryTask] { get }

    // View -> Presenter
    func taskCellTouched(row: Int)
    func addTaskButtonTouched()
    func doneButtonTouched()
    func backButtonTouched()
    func deleteButtonTouched(row: Int)
}

class AddTaskPresenter {
    private weak var view: AddTaskView?
    private let router: AddTaskWireframe
    private let interactor: AddTaskUsecase
    let goal: TemporaryGoal
    var tasks: [TemporaryTask]

    init(view: AddTaskView,
         interactor: AddTaskUsecase,
         router: AddTaskWireframe,
         goal: TemporaryGoal) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.goal = goal
        tasks = []
    }

    private func addNewTask(title: String, targetLevel: Int) {
        let newTask = TemporaryTask(title: title, targetCount: targetLevel)
        tasks.append(newTask)
        view?.reload(tasks: tasks)
    }
}

extension AddTaskPresenter: AddTaskPresentation {
    func addTaskButtonTouched() {
        router.showAddTaskInput(outut: self)
    }

    func taskCellTouched(row: Int) {
        view?.showDeleteAlert(row: row)
    }

    func doneButtonTouched() {
        if tasks.isEmpty {
            view?.validationError(msg: L10n.Localizable.addTaskNilMsg)
            return
        }
        interactor.addGoal(goal: goal,
                           tasks: tasks)
    }

    func backButtonTouched() {
        router.back()
    }

    func deleteButtonTouched(row: Int) {
        tasks.remove(at: row)
        view?.reload(tasks: tasks)
    }
}

extension AddTaskPresenter: AddTaskInteractorOutput {
    func successAddGoal(goal: Goal) {
        router.dismiss()
    }

    func failedAddGoal(msg: String) {
    }
}

extension AddTaskPresenter: TaskInputPresenterOutput {
    func successAddTask(title: String, targetLevel: Int) {
        addNewTask(title: title, targetLevel: targetLevel)
    }
}

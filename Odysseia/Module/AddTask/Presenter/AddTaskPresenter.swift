//
//  AddTaskPresenter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

protocol AddTaskPresentation: AnyObject {
    var tasks: [TemporaryTask] { get }

    // View -> Presenter
    func viewDidLoad()
    func addTaskButtonTouched()
    func nextButtonTouched()
    func taskCellTouched(row: Int)
    func addNewTask(title: String, targetLevel: Int)
    func doneButtonTouched()
}

class AddTaskPresenter {
    private weak var view: AddTaskView?
    private let router: AddTaskWireframe
    private let interactor: AddTaskUsecase
    var tasks: [TemporaryTask]

    init(view: AddTaskView,
         interactor: AddTaskUsecase,
         router: AddTaskWireframe) {
        self.view = view
        self.router = router
        self.interactor = interactor
        tasks = []
    }
}

extension AddTaskPresenter: AddTaskPresentation {
    func viewDidLoad() {

    }

    func addNewTask(title: String, targetLevel: Int) {
        let newTask = TemporaryTask(title: title, targetCount: targetLevel)
        tasks.append(newTask)
        view?.reload(tasks: tasks)
    }

    func addTaskButtonTouched() {
    }

    func nextButtonTouched() {

    }

    func taskCellTouched(row: Int) {

    }

    func doneButtonTouched() {

    }
}

extension AddTaskPresenter: AddTaskInteractorOutput {
    func successAddGoal(goal: Goal) {
    }
    func failedAddGoal(msg: String) {

    }
}

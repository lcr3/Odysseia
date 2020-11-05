//
//  EditTaskInteractor.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

protocol EditTaskUsecase: AnyObject {
    // Interactor -> Presenter
    var output: EditTaskInteractorOutput? { get }
    var service: GoalServicer { get }
    func update(task: Task)
}

class EditTaskInteractor {
    weak var output: EditTaskInteractorOutput?
    let service: GoalServicer

    init(service: GoalServicer) {
        self.service = service
    }
}

extension EditTaskInteractor: EditTaskUsecase {
    func update(task: Task) {
        do {
            let updateTask = try service.update(task: task)
            output?.sccessUpdate(task: updateTask)
        } catch {
            output?.faildUpdate(msg: error.localizedDescription)
        }
    }
}

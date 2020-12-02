//
//  EditTaskInteractor.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

protocol EditTaskUsecase: AnyObject {
    // Interactor -> Presenter
    var output: EditTaskInteractorOutput? { get }
    var service: GoalServiceProtocol { get }
    func update(task: Task)
}

class EditTaskInteractor {
    weak var output: EditTaskInteractorOutput?
    let service: GoalServiceProtocol

    init(service: GoalServiceProtocol) {
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

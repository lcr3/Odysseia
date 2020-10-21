//
//  PersistentContainerProvider.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

import CoreData

class PersistentContainerProvider {

    private init() {}

    private static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Goal")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public static func getInstance() -> NSPersistentContainer {
        persistentContainer
    }
}

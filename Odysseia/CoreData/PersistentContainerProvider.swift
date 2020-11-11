//
//  PersistentContainerProvider.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

class PersistentContainerProvider {
    private init() {}

    private static let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Goal")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public static func getInstance() -> NSPersistentCloudKitContainer {
        persistentContainer
    }
}

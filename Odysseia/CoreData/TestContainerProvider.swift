//
//  TestContainerProvider.swift
//  Odysseia
//
//  Created by lcr on 2020/11/25.
//

import CoreData

class TestProvider: ProviderProtocol {
    private static let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Goal")

        do {
            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                                                        configurationName: nil,
                                                                        at: nil,
                                                                        options: nil)
        } catch {
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    static func getInstance() -> NSPersistentCloudKitContainer {
        persistentContainer
    }
}

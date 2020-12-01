//
//  PersistentContainerProvider.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol ProviderProtocol {
    static func getInstance() -> NSPersistentCloudKitContainer
}

class PersistentContainerProvider: ProviderProtocol {
    private init() {}

    private static let persistentContainer: NSPersistentCloudKitContainer = {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lcr.Odysseia.AppGroup") else {
            fatalError("Load error app group")
        }
        let storeURL = containerURL.appendingPathComponent("Goal.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        let container = NSPersistentCloudKitContainer(name: "Goal")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    public static func getInstance() -> NSPersistentCloudKitContainer {
        persistentContainer
    }
}

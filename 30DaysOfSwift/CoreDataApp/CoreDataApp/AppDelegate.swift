//
//  AppDelegate.swift
//  CoreDataApp
//
//  Created by 王亮 on 2022/8/13.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(application: UIApplication) {
          // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
          // Saves changes in the application's managed object context before the application terminates.
          self.saveContext()
      }

    // MARK: - Core Data
    lazy var applicationDocumentDirectory: URL? = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        if let modelURL = Bundle.main.url(forResource: "coreDataTest", withExtension: "momd") {
            return NSManagedObjectModel(contentsOf: modelURL)
        }
        
        return nil
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let model = self.managedObjectModel else {
            return nil
        }
        
        guard var documentDirectory = self.applicationDocumentDirectory else {
            return nil
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let url = documentDirectory.appendingPathComponent("CoreDataTest.sqlite")
        
        do {
            try coordinator.addPersistentStore(type: .sqlite, configuration: nil, at: url, options: nil)
        } catch {
            var userInfo = [String: Any]()
            var descKey = "Failed to initialize the application's saved data"
            var failureReason = "There was an error creating or loading the application's saved data."
            userInfo[NSLocalizedDescriptionKey] = descKey
            userInfo[NSLocalizedFailureReasonErrorKey] = failureReason
            userInfo[NSUnderlyingErrorKey] = error as NSError
            
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: userInfo)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        guard let coordinator = self.persistentStoreCoordinator else {
            return nil
        }
        
        var managedObjectContext = NSManagedObjectContext(.mainQueue)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func saveContext() {
        if managedObjectContext?.hasChanges == true {
            do {
                try managedObjectContext?.save()
            } catch {
                let error = error as NSError
                NSLog("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
}


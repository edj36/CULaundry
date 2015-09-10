//
//  AppDelegate.swift
//  Laundry
//
//  Created by Eric Johnson  on 7/7/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import UIKit
import CoreData
import Kanna

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var list : [TrackingItem] = []

    // ericjohnson.$(PRODUCT_NAME:rfc1034identifier) bundle ID
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(
            UIApplicationBackgroundFetchIntervalMinimum)
        
        var list = TrackingList.sharedInstance.allItems()
        for x in list {
            TrackingList.sharedInstance.removeItem(x)
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        //var trackingItems: [TrackingItem] = TrackingList.sharedInstance.allItems() // retrieve list of all tracking items
        //UIApplication.sharedApplication().applicationIconBadgeNumber = trackingItems.count // set our badge number to number of Laundry Machines that are being notified
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NSNotificationCenter.defaultCenter().postNotificationName("TrackingListShouldRefresh", object: self)
        var list = TrackingList.sharedInstance.allItems()
        for x in list {
            TrackingList.sharedInstance.removeItem(x)
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //self.saveContext()
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName("TrackingListShouldRefresh", object: self)
        var list = TrackingList.sharedInstance.allItems()
        for x in list {
                TrackingList.sharedInstance.removeItem(x)
        }
        println(list)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    // Support for background fetch
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        println("complete")
        completionHandler(.NewData)
        //getData()
        
    }
    
    func getData() -> Void {
       
        list = TrackingList.sharedInstance.allItems()
        for x in list {
            println("in for")
            var avail = machineList(x.id) // gets list of availibilities
            /*if (avail[x.position] != x.state) {
                println("has changed")
                if (avail[x.position] == "Avail") {
                    println("is now available, firing that notification")
                    var localNotification:UILocalNotification = UILocalNotification()
                    localNotification.alertAction = "Testing notifications on iOS8"
                    localNotification.alertBody = "Your laundry in " + x.label + " is available."
                    localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                    localNotification.userInfo = ["position": x.position, "id": x.id, "UUID": x.UUID]
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                    TrackingList.sharedInstance.removeItem(x) // remove from tracking list
                    //need to set toggle to off on refresh
                }
                if (avail[x.position] == "5 mins left") {
                    println("5 minutes left, sending that notification")
                    var localNotification:UILocalNotification = UILocalNotification()
                    localNotification.alertAction = "Testing notifications on iOS8"
                    localNotification.alertBody = "Your laundry in " + x.label + " has 5 minutes remaining."
                    localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                    localNotification.userInfo = ["position": x.position, "id": x.id, "UUID": x.UUID]
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                    TrackingList.sharedInstance.removeItem(x) // remove from tracking list
                    // need to set toggle to off on refresh
                }
            } else {
                println("nothing changed")
            }
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Testing notifications on iOS8"
            localNotification.alertBody = "Your laundry in " + x.label + " is available."
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
            localNotification.userInfo = ["position": x.position, "id": x.id, "UUID": x.UUID]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            TrackingList.sharedInstance.removeItem(x) // remove from tracking list
            //need to set toggle to off on refresh
            println("sending notification") */
            
            
        }
        
        
    
    }
        
   func loadHTML(myURLString:String)-> String{
        //let myURLString = "http://m.laundryview.com/lvs.php?s=52"
        //let url = NSURL(string: "http://lite.laundryview.com/laundry_room.php?lr=" + siteCode)
        //let url = NSURL(string: "http://lite.laundryview.com/laundry_room.php?lr=1638338")
        
        if let myURL = NSURL(string: myURLString) {
            var error: NSError?
            let myHTMLString = NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding, error: &error)
            if let error = error {
                println("Error : \(error)")
                return "Error"
            } else {
                //println("HTML : \(myHTMLString)")
                return myHTMLString as! String
            }
        } else {
            println("Error: \(myURLString) doesn't seem to be a valid URL")
            return "Error"
        }
    }
    
    func machineList(siteCode:String) ->([String]) {
        let html = loadHTML("http://lite.laundryview.com/laundry_room.php?lr=" + siteCode)
        var machines = [String]()
        var numbers = [String]()
        var availability = [String]()
        if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
            ////li[@id=\"\(start)\"]/following-sibling::li
            for link in doc.xpath("//td/div/span") {
                machines.append(link.text!)
            }
            for (index,name) in enumerate(machines) {
                if (index % 2 == 0){
                    let endIndex = advance(name.startIndex, 2)
                    let short = name.substringToIndex(endIndex)
                    numbers.append(short)
                } else {
                    availability.append(name)
                }
            }
            if (numbers.count == availability.count) {
                return availability
            }
        } else {
            numbers = []
            availability = []
            return availability
        }
        
        return availability
    }
    
        


    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.xxxx.ProjectName" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Laundry.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }


}


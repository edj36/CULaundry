//
//  TrackingList.swift
//  Laundry
//
//  Created by Eric Johnson  on 8/11/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import Foundation
import UIKit

class TrackingList {
    class var sharedInstance : TrackingList {
        struct Static {
            static let instance : TrackingList = TrackingList()
        }
        return Static.instance
    }
    
    private let TRACKING_KEY = "trackingItems"
     let defaults = NSUserDefaults.standardUserDefaults()
    
    //label: String, number: String, state: String, id: String, position: Int, UUID: String
    
    func allItems() -> [TrackingItem] {
        var trackingDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(TRACKING_KEY) ?? [:]
        let items = Array(trackingDictionary.values)
        return items.map({TrackingItem(label: $0["label"] as! String, state: $0["state"] as! String, id: $0["id"] as! String, position: $0["position"] as! Int, alert: $0["alert"] as! Bool, UUID: $0["UUID"] as! String!)})
            //.sorted({(left: TrackingItem.self, right:TrackingItem.self)
            //-> Bool in
            //(left.position.compare(right.position) == .OrderedAscending)
        //})
    }
    
    func addItem(item: TrackingItem) {
        // persist a representation of this todo item in NSUserDefaults
        var trackingDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(TRACKING_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        trackingDictionary[item.UUID] = ["label": item.label, "state": item.state, "id": item.id, "position": item.position, "alert": item.alert, "UUID": item.UUID] // store NSData representation of todo item in dictionary with UUID as key
        NSUserDefaults.standardUserDefaults().setObject(trackingDictionary, forKey: TRACKING_KEY) // save/overwrite todo item list
        
       /* // create a corresponding local notification
        var notification = UILocalNotification()
        notification.alertBody = "Your laundry in \"\(item.label)\" is done!" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        //notification.fireDate = item.deadline // todo item due date (when notification will be fired)
        //notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        
        // identifier is position and site code (id) and UUID
        notification.userInfo = ["position": item.position, "id": item.id, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)*/
    }
    
    func removeItem(item: TrackingItem) {
        defaults.setBool(false, forKey: "alertOn")
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification] { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
        
        if var trackingItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(TRACKING_KEY) {
            trackingItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(trackingItems, forKey: TRACKING_KEY) // save/overwrite todo item list
        }
    }
    
}
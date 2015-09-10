//
//  CustomTableViewCell.swift
//  Laundry
//
//  Created by Eric Johnson  on 8/10/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //var icon = UIImageView()
    //var machineNumber = UILabel()
    //var machineState = UILabel()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var machineNumber: UILabel!
    
    @IBOutlet weak var machineState: UILabel!
   
    @IBOutlet weak var machineIcon: UIImageView!
    
    @IBOutlet weak var minsLeft: UILabel!
    
    @IBAction func alertToggle(sender: UISwitch) {
        
        if sender.on {

            defaults.setBool(true, forKey: "alertOn")
            let trackingItem = TrackingItem(label: self.machineNumber.text!, state: self.machineState.text!, id: defaults.objectForKey("siteCode") as! String, position: self.tag, alert: true, UUID: NSUUID().UUIDString)
            TrackingList.sharedInstance.addItem(trackingItem)
            //var timeLeft: Int
            //timeLeft = minsLeftInt(minsLeft.text!)
            var secondsLeft: NSTimeInterval
            //secondsLeft = timeLeft * 60
            //println(timeLeft)
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "open"
            localNotification.alertBody = "Your laundry in " + trackingItem.label + " will be ready in 5 minutes."
            localNotification.timeZone = NSTimeZone.localTimeZone()
            localNotification.fireDate = NSDate(timeIntervalSinceNow: minsLeftInt(minsLeft.text!))
            localNotification.applicationIconBadgeNumber = 1
            localNotification.userInfo = ["position": trackingItem.position, "id": trackingItem.id, "UUID": trackingItem.UUID]
            localNotification.applicationIconBadgeNumber = TrackingList.sharedInstance.allItems().count
            localNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            //label: String, number: String, state: String, id: String, position: Int, UUID: String
            
            
        } else {
            defaults.setBool(false, forKey: "alertOn")
            var list = TrackingList.sharedInstance.allItems()
            for x in list {
                if ((x.id == defaults.objectForKey("siteCode") as! String) && (x.position == self.tag)) {
                    TrackingList.sharedInstance.removeItem(x)
                }
            }
            println(TrackingList.sharedInstance.allItems())
        }
    }
    
    @IBOutlet weak var alertSwitch: UISwitch!
    
    @IBOutlet weak var notify: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func minsLeftInt(minsLeft:String) -> NSTimeInterval {
        var firstPart: String
        var mins: Int
        var range = minsLeft.rangeOfString(" ")
        firstPart = minsLeft.substringToIndex(range!.startIndex)
        println(firstPart) // print Hello
        var min = (firstPart.toInt()! * 60) - 300
        // less than 5 minutes left?
        
        let x: NSTimeInterval = NSTimeInterval(Int(min))
        return x
    }
    

    
    


    
}





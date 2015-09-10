//
//  TipsViewController.swift
//  Laundry
//
//  Created by Eric Johnson  on 8/4/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var screenSize:CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        
        var doneButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        doneButton.frame = CGRectMake(screenWidth - (screenWidth/6), screenHeight/24, 60, 40)
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.center = CGPointMake((screenWidth - (screenWidth/6)) + 30, (screenHeight/10) - 6 )
        doneButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        doneButton.setTitleColor(UIColor(red: 0.20392157, green: 0.28627451, blue: 0.36862745, alpha: 1.0), forState: UIControlState.Normal)
        doneButton.addTarget(self, action: "doneButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        //doneButton.center = CGPoint(x: (screenWidth/2), y: (screenHeight/4+68))
        //doneButton.layer.cornerRadius = 5
        self.view.addSubview(doneButton)
        
        var titleLabel = UILabel(frame: CGRectMake(0, 0, screenWidth/2, 40))
        titleLabel.center = CGPointMake(screenWidth/2, (screenHeight/10) - 4)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.numberOfLines = 0
        titleLabel.text = "Tips"
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        //titleLabel.layer.cornerRadius = 5
        //titleLabel.layer.borderColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0).CGColor
        //titleLabel.layer.borderWidth = 4
        self.view.addSubview(titleLabel)
        
        /* var tipsText = UILabel(frame: CGRectMake(4, screenHeight/10, screenWidth - 4, ((9 * screenHeight)/10)))
        //tipsText.center = CGPointMake(screenWidth/2, (screenHeight/10) - 4)
        tipsText.textAlignment = NSTextAlignment.Left
        tipsText.numberOfLines = 0
        tipsText.text = "•To use the app: Select where you live on campus (North Campus, West Campus, etc) and then select your dormitory to view the laundry there in real time \n\n•If you turn on the 'Notify' switch, you will be notified when there are 5 minutes left on the corresponding machine cycle \n\n•Setting a default dorm allows you to skip the steps of selecting where you live and jump right to viewing the machines in your ‘home’ laundry room \n\n•If a machine says 'Unknown' that means the washing/drying cycle has ended but whoever has their clothes in the machine has not taken them out yet \n\n•Don't hesitate to give feed back! I will build new ideas into upcoming versions to make the app better"
        tipsText.font = UIFont(name: "HelveticaNeue", size: 14)
        //tipsText.backgroundColor = UIColor.clearColor()
        tipsText.backgroundColor = UIColor.blueColor()
        tipsText.textColor = UIColor.blackColor()
        self.view.addSubview(tipsText) */
        
        var tips = UITextView(frame: CGRectMake(4, (screenHeight/10) + 4, screenWidth - 4, ((9 * screenHeight)/10)))
        tips.textAlignment = NSTextAlignment.Left
        tips.text = "•To use the app: Select where you live on campus (North Campus, West Campus, etc) and then select your dormitory to view the laundry there in real time \n\n•If you turn on the 'Notify' switch, you will be notified when there are 5 minutes left on the corresponding machine cycle \n\n•Setting a default dorm allows you to skip the steps of selecting where you live and jump right to viewing the machines in your ‘home’ laundry room \n\n•If a machine says 'Unknown' that means the washing/drying cycle has ended but whoever has their clothes in the machine has not taken them out yet \n\n•Don't hesitate to give feed back! I will build new ideas into upcoming versions to make the app better"
        tips.font = UIFont(name: "HelveticaNeue", size: 14)
        tips.backgroundColor = UIColor.clearColor()
        tips.textColor = UIColor.blackColor()
        self.view.addSubview(tips)
        
    }
    
    /* Transitions to SettingsViewController */
    func doneButtonAction(sender:UIButton!)
    {
        // add cool segue
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

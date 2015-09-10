//
//  SettingsViewController.swift
//  Laundry
//
//  Created by Eric Johnson  on 8/4/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController {
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        var screenSize:CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
     
        navigationItem.leftBarButtonItem = nil
        // set a default laundry room
        
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
        titleLabel.text = "Settings"
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        //titleLabel.layer.cornerRadius = 5
        //titleLabel.layer.borderColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0).CGColor
        //titleLabel.layer.borderWidth = 4
        self.view.addSubview(titleLabel)
        
        var label = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        label.frame = CGRectMake(10, (2 * screenHeight)/10 - 24, screenWidth - 12, 54)
        label.center = CGPointMake(screenWidth/2, (2 * screenHeight/10) - 6)
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "‌Set or reset your default dorm by clicking the 'Default' button and navigating to your dorm (and then save the dorm as your default dorm)"
        self.view.addSubview(label)
        
        let resetDefault = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        resetDefault.frame = CGRectMake(0, 0, (3 * screenWidth/4), 36)
        resetDefault.setTitle("Default", forState: UIControlState.Normal)
        resetDefault.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        resetDefault.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        resetDefault.addTarget(self, action: "resetButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        resetDefault.center = CGPoint(x: (screenWidth/2), y: (3 * screenHeight/10) - 6)
        resetDefault.layer.cornerRadius = 5
        resetDefault.titleLabel!.textColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        resetDefault.layer.borderColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0).CGColor
        resetDefault.layer.borderWidth = 4
        self.view.addSubview(resetDefault)
        
        var moneyLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        moneyLabel.textAlignment = NSTextAlignment.Left
        moneyLabel.numberOfLines = 1
        moneyLabel.frame = CGRectMake(10, (4 * screenHeight/10) - 24, (3 * screenWidth/5), 36)
        //moneyLabel.center = CGPointMake((screenWidth/5) + 10, (4 * screenHeight/10) - 6)
        moneyLabel.adjustsFontSizeToFitWidth = true
        moneyLabel.text = "‌•Add money to your Laundry account"
        moneyLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(moneyLabel)
        
        let moremoney = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        moremoney.frame = CGRectMake(0, 0, screenWidth/4, 36)
        moremoney.center = CGPointMake((screenWidth/5) * 4 + 8, (4 * screenHeight/10) - 6)
        moremoney.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        moremoney.layer.cornerRadius = 5
        moremoney.setTitle("Money", forState: UIControlState.Normal)
        moremoney.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        moremoney.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        moremoney.addTarget(self, action: "moneyButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(moremoney)
        
        var reportLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        reportLabel.textAlignment = NSTextAlignment.Left
        reportLabel.numberOfLines = 0
        reportLabel.frame = CGRectMake(10, (5 * screenHeight/10) - 24, (3 * screenWidth/5), 36)
        //reportLabel.center = CGPointMake((screenWidth/5), (5 * screenHeight/10) - 6)
        reportLabel.adjustsFontSizeToFitWidth = true
        reportLabel.text = "‌•Report a broken machine"
        reportLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(reportLabel)
        
        let report = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        report.frame = CGRectMake(0, 0, screenWidth/4, 36)
        report.center = CGPointMake((screenWidth/5) * 4 + 8, (5 * screenHeight/10) - 6)
        report.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        report.layer.cornerRadius = 5
        report.setTitle("Report", forState: UIControlState.Normal)
        report.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 14)
        report.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        report.addTarget(self, action: "reportButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(report)
        
        var maintenanceLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        maintenanceLabel.textAlignment = NSTextAlignment.Left
        maintenanceLabel.numberOfLines = 0
        maintenanceLabel.frame = CGRectMake(10, (6 * screenHeight/10) - 24, (3 * screenWidth/5), 36)
        //maintenanceLabel.center = CGPointMake((screenWidth/5), (6 * screenHeight/10) - 6)
        maintenanceLabel.adjustsFontSizeToFitWidth = true
        maintenanceLabel.text = "‌•Place a maintenance request for laundry room"
        maintenanceLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(maintenanceLabel)
        
        let maintenance = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        maintenance.frame = CGRectMake(0, 0, screenWidth/4, 36)
        maintenance.center = CGPointMake((screenWidth/5) * 4 + 8, (6 * screenHeight/10) - 6)
        maintenance.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        maintenance.layer.cornerRadius = 5
        maintenance.setTitle("Request", forState: UIControlState.Normal)
        maintenance.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        maintenance.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        maintenance.addTarget(self, action: "maintenanceButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(maintenance)
        
        var feedbackLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        feedbackLabel.textAlignment = NSTextAlignment.Left
        feedbackLabel.numberOfLines = 0
        feedbackLabel.frame = CGRectMake(10, (7 * screenHeight/10) - 24, (3 * screenWidth/5), 36)
        //feedbackLabel.center = CGPointMake((screenWidth/5), (7 * screenHeight/10) - 6)
        feedbackLabel.adjustsFontSizeToFitWidth = true
        feedbackLabel.text = "‌•Send feedback about CU Laundry"
        feedbackLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(feedbackLabel)
        
        let feedback = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        feedback.frame = CGRectMake(0, 0, screenWidth/4, 36)
        feedback.center = CGPointMake((screenWidth/5) * 4 + 8, (7 * screenHeight/10) - 6)
        feedback.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        feedback.layer.cornerRadius = 5
        feedback.setTitle("Feedback", forState: UIControlState.Normal)
        feedback.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        feedback.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        feedback.addTarget(self, action: "feedbackButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(feedback)
        
        var tipsLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        tipsLabel.textAlignment = NSTextAlignment.Left
        tipsLabel.numberOfLines = 0
        tipsLabel.frame = CGRectMake(10, (8 * screenHeight/10) - 24, (3 * screenWidth/5), 36)
        //feedbackLabel.center = CGPointMake((screenWidth/5), (7 * screenHeight/10) - 6)
        tipsLabel.adjustsFontSizeToFitWidth = true
        tipsLabel.text = "‌•Tips for using CU Laundry"
        tipsLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(tipsLabel)
        
        let tips = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        tips.frame = CGRectMake(0, 0, screenWidth/4, 36)
        tips.center = CGPointMake((screenWidth/5) * 4 + 8, (8 * screenHeight/10) - 6)
        tips.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        tips.layer.cornerRadius = 5
        tips.setTitle("Tips", forState: UIControlState.Normal)
        tips.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tips.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        tips.addTarget(self, action: "tipsButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tips)
        
        var rateLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, screenHeight/4))
        rateLabel.textAlignment = NSTextAlignment.Left
        rateLabel.numberOfLines = 0
        rateLabel.frame = CGRectMake(10, (9 * screenHeight/10) - 24, (3 * screenWidth/5), 36)
        //feedbackLabel.center = CGPointMake((screenWidth/5), (7 * screenHeight/10) - 6)
        rateLabel.adjustsFontSizeToFitWidth = true
        rateLabel.text = "‌•Click to rate CU Laundry"
        rateLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.view.addSubview(rateLabel)
        
        let rate = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        rate.frame = CGRectMake(0, 0, screenWidth/4, 36)
        rate.center = CGPointMake((screenWidth/5) * 4 + 8, (9 * screenHeight/10) - 6)
        rate.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 1.0)
        rate.layer.cornerRadius = 5
        rate.setTitle("Rate", forState: UIControlState.Normal)
        rate.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rate.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        rate.addTarget(self, action: "rateButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(rate)
        
    }
    
    /* Transitions to AreasViewController, but with default set to false */
    func resetButtonAction(sender:UIButton!)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "defaultSet")
        defaults.synchronize()
        // add cool segue
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* Transitions to AreasViewController */
    func doneButtonAction(sender:UIButton!)
    {
        // add cool segue
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* Opens Url linking to Cornell Laundry Account Page */
    func moneyButtonAction(sender:UIButton!)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://card.campuslife.cornell.edu/")!)
    }
    
    /* Opens Url linking to LaundryView Report Machine Page */
    func reportButtonAction(sender:UIButton!)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://servicerequest.asicampuslaundry.com/ASIServiceRequest.aspx")!)
    }
    
    /* Opens Url linking to Cornell Maintenance Request Page */
    func maintenanceButtonAction(sender:UIButton!)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://web4.login.cornell.edu/?SID=64648FCDAA606BAF&WAK0Service=HTTP/maximo.fs.cornell.edu@CIT.CORNELL.EDU&WAK2Name=&WAK0Realms=&ReturnURL=https://maximo.fs.cornell.edu:8474/64648FCDAA606BAF/cuwal2.c0ntinue&VerP=2&VerC=2.2.0.183/idmbuild@WIN2K3X64BS.cit.cornell.edu/Win32-Win32-183/2.2.10&amp;VerS=Microsoft-IIS/6.0%2020150812-0528&amp;VerO=unknown&Accept=K2&WANow=1439447328&WAK2Flags=0&WAreason=1")!)
    }
    
    /* Starts new email with feedback */
    func feedbackButtonAction(sender:UIButton!)
    {
        let url = NSURL(string: "mailto:edj36@cornell.edu")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    /* Transitions to tips page */
    func tipsButtonAction(sender:UIButton!)
    {
        let vc = TipsViewController(nibName: "AreasViewController", bundle: nil)
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: true, completion: nil)
    }
    
    /* Transitions to rate in app store */
    func rateButtonAction(sender:UIButton!)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://itunes.apple.com/app/id1037065579")!)
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
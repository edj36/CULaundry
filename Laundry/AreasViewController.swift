//
//  AreasViewController.swift
//  Laundry
//
//  Created by Eric Johnson  on 8/4/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import UIKit



class AreasViewController: UIViewController {

    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome to CULaundry"
        var screenSize:CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        var name = randomPhoto()
        applyBlurEffect()
        var imageView: UIImageView
        imageView = UIImageView(frame:CGRectMake(0, 0, screenWidth, screenHeight));
        imageView.contentMode = UIViewContentMode.ScaleToFill
        imageView.image = UIImage(named: name)
        self.view.addSubview(imageView)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        
        
        
        let north = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        north.frame = CGRectMake(0, 0, (5 * screenWidth)/12, (5 * screenWidth)/12)
        north.backgroundColor = UIColor.redColor()
        north.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 0.9)
        north.setTitle("North Campus", forState: UIControlState.Normal)
        north.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        north.addTarget(self, action: "northButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        north.center = CGPoint(x: ((screenWidth/2) - (5 * screenWidth)/24) - 2, y: ((screenHeight/2) - (5 * screenWidth)/24) - 2)
        north.layer.cornerRadius = 5
        self.view.addSubview(north)
        
        let west = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        west.frame = CGRectMake(0, 0, (5 * screenWidth)/12, (5 * screenWidth)/12)
        west.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 0.9)
        west.setTitle("West Campus", forState: UIControlState.Normal)
        west.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        west.addTarget(self, action: "westButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        west.center = CGPoint(x: ((screenWidth/2) + (5 * screenWidth)/24) + 2, y: ((screenHeight/2) - (5 * screenWidth)/24) - 2)
        west.layer.cornerRadius = 5
        self.view.addSubview(west)
        
        let collegeTown = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        collegeTown.frame = CGRectMake(0, 0, (5 * screenWidth)/12, (5 * screenWidth)/12)
        collegeTown.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 0.9)
        collegeTown.setTitle("College Town", forState: UIControlState.Normal)
        collegeTown.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        collegeTown.addTarget(self, action: "collegeTownButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        collegeTown.center = CGPoint(x: ((screenWidth/2) - (5 * screenWidth)/24) - 2, y: ((screenHeight/2) + (5 * screenWidth)/24) + 2)
        collegeTown.layer.cornerRadius = 5
        self.view.addSubview(collegeTown)
        
        let graduate = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        graduate.frame = CGRectMake(0, 0, (5 * screenWidth)/12, (5 * screenWidth)/12)
        graduate.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 0.9)
        graduate.setTitle("Graduate Housing", forState: UIControlState.Normal)
        graduate.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        graduate.addTarget(self, action: "graduateButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        graduate.center = CGPoint(x: ((screenWidth/2) + (5 * screenWidth)/24) + 2, y: ((screenHeight/2) + (5 * screenWidth)/24) + 2)
        graduate.layer.cornerRadius = 5
        self.view.addSubview(graduate)
        
        let defaultRoom = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        defaultRoom.frame = CGRectMake(0, 0, ((10 * screenWidth)/12) + 4, (5 * screenWidth)/36)
        defaultRoom.backgroundColor = UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 0.9)
        defaultRoom.setTitle("Use Default Dorm", forState: UIControlState.Normal)
        defaultRoom.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        defaultRoom.addTarget(self, action: "defaultButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        defaultRoom.center = CGPoint(x: (screenWidth/2), y: (screenHeight/2) + ((5 * screenWidth)/12) + ((5 * screenWidth)/48) + 2)
        defaultRoom.layer.cornerRadius = 5
        self.view.addSubview(defaultRoom)
        
        var settingsButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "settingsButtonAction") //Use a selector
        navigationItem.leftBarButtonItem = settingsButton
        
        
        /*var tipsButton = UIBarButtonItem(title: "Tips", style: .Plain, target: self, action: "tipsButtonAction") //Use a selector
        navigationItem.rightBarButtonItem = tipsButton*/
       
       
    }
    
    /* Transitions to ViewController, passes XPath to parse for North*/
    func northButtonAction(sender:UIButton!)
    {
        let vc = ViewController(nibName: "AreasViewController", bundle: nil)
        vc.toPass = "NORTHCAMPUS"
        vc.alsoPass = "WESTCAMPUS"
        //div[@class="listEntryTitle"]/a[@class="infoLink detailsViewLink"]/text()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /* Transitions to ViewController, passes XPath to parse for West*/
    func westButtonAction(sender:UIButton!)
    {
        let vc = ViewController(nibName: "AreasViewController", bundle: nil)
        vc.toPass = "WESTCAMPUS"
        vc.alsoPass = "null"
        navigationController?.pushViewController(vc, animated: true )
    }
    
    /* Transitions to ViewController, passes XPath to parse for CollegeTown*/
    func collegeTownButtonAction(sender:UIButton!)
    {
        let vc = ViewController(nibName: "AreasViewController", bundle: nil)
        vc.toPass = "COLLEGETOWN"
        vc.alsoPass = "GRADUATEHOUSING"
        navigationController?.pushViewController(vc, animated: true )
    }
    
    /* Transitions to ViewController, passes Xpath to parse for Graduate*/
    func graduateButtonAction(sender:UIButton!)
    {
        let vc = ViewController(nibName: "AreasViewController", bundle: nil)
        vc.toPass = "GRADUATEHOUSING"
        vc.alsoPass = "NORTHCAMPUS"
        navigationController?.pushViewController(vc, animated: true )
    }
    
    /* Transitions to Default MachineRoomViewController, passes XPath to parse for default*/
    func defaultButtonAction(sender:UIButton!)
    {
        // use user defaults to set default room, can only set/reset the defualt in settings
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        if (defaults.boolForKey("defaultSet") == true) {
            //let vc = MachinesViewController(nibName: "MachinesViewController", bundle: nil)
            let vc = MachinesViewController()
            var name:String
            name = defaults.stringForKey("defaultRoom")!
            vc.toPass = name
            // pass default name
            navigationController?.pushViewController(vc, animated: true)
        } else {
            chillPopup()
        }
    }
    
    /* Transitions to SettingsViewController */
    func settingsButtonAction()
    {
        let vc = SettingsViewController(nibName: "AreasViewController", bundle: nil)
        vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        presentViewController(vc, animated: true, completion: nil)
    }
    
    /* Transitions to TipsViewController */
    func tipsButtonAction()
    {
        let vc = TipsViewController(nibName: "TipsViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true )
    }
    
    func chillPopup() {
        // Create popup has to know whether or default is set
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        var ContainerView = UIView(frame: CGRectMake((width / 2) - 100, ((height - 37) / 2) - (35/2), 200, 35))
        var DynamicView = UIView(frame: CGRectMake(0, 0, 200, 35))
        var label = UILabel(frame: CGRectMake(0, 0, 200, 35))
        
        DynamicView.backgroundColor = UIColor(red: 0.5, green: 0.4, blue: 0.32, alpha: 1.0)
        DynamicView.layer.cornerRadius = 6
        label.text = "Set your default dorm in Settings"
        label.font =  UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        
        view.addSubview(ContainerView)
        ContainerView.addSubview(DynamicView)
        DynamicView.addSubview(label)
        
        ContainerView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        ContainerView.alpha = 0.0;
        
        UIView.animateWithDuration(0.25, animations: {
            ContainerView.alpha = 1.0
            ContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion:{(finished : Bool)  in
                if (finished) {
                    UIView.animateWithDuration(2, animations: {
                        ContainerView.alpha = 0.99;
                        }, completion:{(finished : Bool)  in
                            if (finished) {
                                UIView.animateWithDuration(0.25, animations: {
                                    ContainerView.alpha = 0.0;
                                    }, completion:{(finished : Bool)  in
                                        if (finished) {
                                            ContainerView.removeFromSuperview()
                                        }
                                });
                            }
                    });
                }
        });
    }
    
    func randomPhoto()-> String{
        //let array = ["slope.jpg", "beebe.jpg", "slope-blur.jpg"]
        let array = ["beebe.JPG", "clock.jpg", "option3.jpg", "option6.jpg", "option7.jpg"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        return array[randomIndex]
    }
    
    func applyBlurEffect(){
        /*var imageToBlur = CIImage(image: image)
        var blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter.setValue(imageToBlur, forKey: "inputImage")
        var resultImage = blurfilter.valueForKey("outputImage") as! CIImage
        var blurredImage = UIImage(CIImage: resultImage)
        self.blurImageView.image = blurredImage*/
        
        // 1
        let blurEffect = UIBlurEffect(style: .Light)
        // 2
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 3
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.insertSubview(blurView, atIndex: 0)
        
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

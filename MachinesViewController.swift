//
//  MachinesViewController.swift
//  
//
//  Created by Eric Johnson  on 8/4/15.
//
//

import UIKit
import Kanna

class MachinesViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource  {
    // url for testing queries http://videlibri.sourceforge.net/cgi-bin/xidelcgi
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var toPass:String!
    //var tableView:UITableView
    var machineNumberList = [String]()
    var machineAvailabilityList = [String]()
    var machineTypeList = [String]()
    var iconList = [UIImage]()
    var siteCode:String!
    
    var refreshLoadingView : UIView!
    var refreshColorView : UIView!
    var compass_background : UIImageView!
    var compass_spinner : UIImageView!
    
    var isRefreshIconsOverlap = false
    var isRefreshAnimating = false
    let defaults = NSUserDefaults.standardUserDefaults()
    var list : [TrackingItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.setObject(getSiteCode(toPass), forKey: "siteCode")
        list = TrackingList.sharedInstance.allItems()
      
        self.title = toPass
        if (defaults.boolForKey("defaultSet") == true) {
            // chillin
        } else {
           showDefaultChooser()
        }
       
        var screenSize:CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        self.siteCode = getSiteCode(toPass)
        self.machineNumberList = machineList(siteCode).0
        self.machineAvailabilityList = machineList(siteCode).1
        self.iconList = iconDecider(siteCode).0
        self.machineTypeList = iconDecider(siteCode).1
       
        // TODO: another function to determine washer or dryer
        
        
        self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        //tableView.registerNib(UINib(nibName: CustomTableViewCell.self, bundle: nil), forCellReuseIdentifier: "cell")
        //self.view.addSubview(tableView)
        
        self.setupRefreshControl()
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    // TableView things
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.machineNumberList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomTableViewCell
        
        if var number = cell.machineNumber {
            cell.machineNumber.text = self.machineTypeList[indexPath.row] + " " + self.machineNumberList[indexPath.row]
            //cell.machineNumber.adjustsFontSizeToFitWidth = true
            cell.machineNumber.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            cell.machineNumber.center = CGPointMake(0, 28)
            cell.machineNumber.textAlignment = NSTextAlignment.Left
            
        }
        if var status = cell.machineState {
            if (self.machineAvailabilityList[indexPath.row] == "Avail") {
                cell.machineState.text = "Available"
                cell.machineState.font = UIFont(name: "HelveticaNeue-Light", size: 14)
                cell.machineState.center = CGPointMake(0, 28)
                cell.machineState.textAlignment = NSTextAlignment.Left
                
            }
            else {
                cell.machineState.text = self.machineAvailabilityList[indexPath.row]
                cell.machineState.font = UIFont(name: "HelveticaNeue-Light", size: 14)
                cell.machineState.center = CGPointMake(0, 28)
                cell.machineState.textAlignment = NSTextAlignment.Left
            }
            
        }
        
        cell.tag = indexPath.row
        
        if var icon = cell.machineIcon {
            if ((self.machineTypeList[indexPath.row] == "Washer") && (self.machineAvailabilityList[indexPath.row] == "Avail")) {
                cell.machineIcon.image = UIImage(named: "machineIcon@88px.png")
            }
            else if ((self.machineTypeList[indexPath.row] == "Washer") && (self.machineAvailabilityList[indexPath.row] == "Out of service")) {
                cell.machineIcon.image = UIImage(named: "outOfServiceMachineIcon@88px.png")
            }
            else if ((self.machineTypeList[indexPath.row] == "Washer") && (self.machineAvailabilityList[indexPath.row] != "Avail")) {
            
            var imgListArray :NSMutableArray = []
            for countValue in 1...5
            {
            
            var strImageName : String = "w\(countValue).png"
            var image  = UIImage(named:strImageName)
            imgListArray .addObject(image!)
            }
            
            cell.machineIcon.animationImages = imgListArray as [AnyObject];
            cell.machineIcon.animationDuration = 1.0
            cell.machineIcon.startAnimating()
            
            }
            else if ((self.machineTypeList[indexPath.row] == "Dryer") && (self.machineAvailabilityList[indexPath.row] == "Avail")) {
                cell.machineIcon.image = UIImage(named: "dryerIcon@88px.png")
            }
            else if ((self.machineTypeList[indexPath.row] == "Dryer") && (self.machineAvailabilityList[indexPath.row] == "Out of service")) {
                cell.machineIcon.image = UIImage(named: "outOfServiceDryerIcon@88px.png")
            }
            else if ((self.machineTypeList[indexPath.row] == "Dryer") && (self.machineAvailabilityList[indexPath.row] != "Avail")) {
                
                var imgListArray :NSMutableArray = []
                for countValue in 1...2
                {
                    
                    var strImageName : String = "d\(countValue).png"
                    var image  = UIImage(named:strImageName)
                    imgListArray .addObject(image!)
                }
                
                cell.machineIcon.animationImages = imgListArray as [AnyObject];
                cell.machineIcon.animationDuration = 1.0
                cell.machineIcon.startAnimating()
                
            }
            
    
        }
        
        
       
        
        if var toggle = cell.alertSwitch {
            cell.alertSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
            cell.alertSwitch.onTintColor = UIColor.redColor()
            var list = TrackingList.sharedInstance.allItems()
            for x in list {
                if ((x.id == (defaults.objectForKey("siteCode") as! String)) && (x.position == indexPath.row)) {
                    cell.alertSwitch.setOn(true, animated: true)
                }
            }
            
            //cell.alertToggle.frame = CGRectMake(screenWidth - 2, 0, 1, 1)
        }
        if var notify = cell.notify {
            cell.notify.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
            cell.notify.center = CGPointMake(0, 28)
            cell.notify.textAlignment = NSTextAlignment.Left
        }
        
        if var minsLeft = cell.minsLeft {
            cell.minsLeft.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
            cell.minsLeft.text = self.machineAvailabilityList[indexPath.row]
            cell.minsLeft.textAlignment = NSTextAlignment.Left
        }
        
        // extended cycle too
        if ((self.machineAvailabilityList[indexPath.row] == "Avail") || (self.machineAvailabilityList[indexPath.row] == "Out of service") || (self.machineAvailabilityList[indexPath.row] == "Unknown") || (self.machineAvailabilityList[indexPath.row] == "Offline") || (self.machineAvailabilityList[indexPath.row] == "Extended Cycle")) {
            cell.machineState.hidden = false
            cell.alertSwitch.hidden = true
            cell.notify.hidden = true
            cell.minsLeft.hidden = true
        } else {
            cell.machineState.hidden = true
            cell.notify.hidden = false
            cell.alertSwitch.hidden = false
            cell.minsLeft.hidden = false
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // notification/track the machine?
        
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
    
    func getSiteCode(siteName:String)->String {
        let html = loadHTML("http://m.laundryview.com/lvs.php?s=52")
        var ids = [String]()
        var names = [String]()
        if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
            for link in doc.xpath("//li/a/@id") {
                ids.append(link.text!)
            }
        }
        if let doc = Kanna.HTML(html: html, encoding:NSUTF8StringEncoding) {
            for link in doc.xpath("//li/a") {
                names.append(link.text!)
            }
        }
        let index = find(names, siteName)
        //fatal error: unexpectedly found nil while unwrapping an Optional value (lldb)
        return ids[index!]
    }
    
    
    func machineList(siteCode:String) ->([String],[String]) {
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
                return (numbers,availability)
            }
        } else {
            numbers = []
            availability = []
            return (numbers, availability)
        }
        
        return (numbers, availability)
    }
    
    
    func iconDecider(siteCode:String) -> ([UIImage],[String]) {
        let html = loadHTML("http://lite.laundryview.com/laundry_room.php?lr=" + siteCode)
        var icons = [UIImage]()
        var list = [String]()
        var types = [String]()
        if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
            for link in doc.xpath("//td/div/@class") {
                list.append(link.text!)
            }
            list.count
            let slice = list[2..<list.count]
            let numWashers = find(slice, "header")
            let slice2 = slice[2 + numWashers!..<slice.count]
            let numDryers = slice2.count
            if (numDryers + numWashers! == self.machineNumberList.count) {
                var machines = [String]()
                for count in 1...numWashers!{
                    machines.append("Washer")
                }
                for count in 1...numDryers{
                    machines.append("Dryer")
                }
                for count in  0...machines.count - 1 {
                    if (machines[count] == "Washer") {
                        if (self.machineAvailabilityList[count] == "Avail") {
                            // append green washer
                            icons.append(UIImage(named: "machineIcon@88px.png")!)
                        }
                        else if (self.machineAvailabilityList[count] == "Out of service") {
                            // append grey washer
                            icons.append(UIImage(named: "outOfServiceMachineIcon@88px.png")!)
                        }
                        else {
                            // append red gif but for now boring black one
                            icons.append(UIImage(named:"otherwasher.png")!)
                        }
                    }
                    if (machines[count] == "Dryer"){
                        // these better all be dryers I hope 
                        if (self.machineAvailabilityList[count] == "Avail") {
                            // append green dryer
                            icons.append(UIImage(named: "dryerIcon@88px.png")!)
                        }
                        else if (self.machineAvailabilityList[count] == "Out of service") {
                            // append grey dryer
                            icons.append(UIImage(named: "outOfServiceDryerIcon@88px.png")!)
                        }
                        else {
                            // append red gif but for now boring black one
                            icons.append(UIImage(named: "otherwasher-copy.png")!)
                        }
                    }
                }
                return (icons, machines)
            }
        }
        return (icons,types)
    }
    
    func showDefaultChooser() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var alert = UIAlertController(title: "Set this dorm as your default?", message: "You can always reset in the settings.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { alertAction in
            defaults.setObject(self.toPass, forKey: "defaultRoom")
            defaults.setBool(true, forKey: "defaultSet")
            defaults.synchronize()
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { alertAction in
            defaults.setBool(false, forKey: "defaultSet")
            defaults.synchronize()
            alert.dismissViewControllerAnimated(true, completion: nil)
        
        }))
        
        // Display rate alert
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // For pull down refreshing
    
    func setupRefreshControl() {
        
        // Programmatically inserting a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        
        // Setup the loading view, which will hold the moving graphics
        self.refreshLoadingView = UIView(frame: self.refreshControl!.bounds)
        self.refreshLoadingView.backgroundColor = UIColor.clearColor()
        
        // Setup the color view, which will display the rainbowed background
        self.refreshColorView = UIView(frame: self.refreshControl!.bounds)
        self.refreshColorView.backgroundColor = UIColor.clearColor()
        self.refreshColorView.alpha = 0.30
        
        // Create the graphic image views
        compass_background = UIImageView(image: UIImage(named: "otherwasher-copy.png"))
        self.compass_spinner = UIImageView(image: UIImage(named: "spinner.png"))
        
        // Add the graphics to the loading view
        self.refreshLoadingView.addSubview(self.compass_background)
        //self.refreshLoadingView.addSubview(self.compass_spinner)
        
        // Clip so the graphics don't stick out
        self.refreshLoadingView.clipsToBounds = true;
        
        // Hide the original spinner icon
        self.refreshControl!.tintColor = UIColor.clearColor()
        
        // Add the loading and colors views to our refresh control
        self.refreshControl!.addSubview(self.refreshColorView)
        self.refreshControl!.addSubview(self.refreshLoadingView)
        
        // Initalize flags
        self.isRefreshIconsOverlap = false;
        self.isRefreshAnimating = false;
        
        // When activated, invoke our refresh function
        self.refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh(){
        
        // -- DO SOMETHING AWESOME (... or just wait 3 seconds) --
        // This is where you'll make requests to an API, reload data, or process information
        var delayInSeconds = 0.3;
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            // When done requesting/reloading/processing invoke endRefreshing, to close the control
            // reload table view data
            self.list = TrackingList.sharedInstance.allItems()
            self.siteCode = self.getSiteCode(self.toPass)
            self.machineNumberList = self.machineList(self.siteCode).0
            self.machineAvailabilityList = self.machineList(self.siteCode).1
            self.iconList = self.iconDecider(self.siteCode).0
            self.machineTypeList = self.iconDecider(self.siteCode).1
            self.tableView.reloadData()
            self.refreshControl!.endRefreshing()
        }
        // -- FINISHED SOMETHING AWESOME, WOO! --
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // Get the current size of the refresh controller
        var refreshBounds = self.refreshControl!.bounds;
        
        // Distance the table has been pulled >= 0
        var pullDistance = max(0.0, -self.refreshControl!.frame.origin.y);
        
        // Half the width of the table
        var midX = self.tableView.frame.size.width / 2.0;
        
        // Calculate the width and height of our graphics
        var compassHeight = self.compass_background.bounds.size.height;
        var compassHeightHalf = compassHeight / 2.0;
        
        var compassWidth = self.compass_background.bounds.size.width;
        var compassWidthHalf = compassWidth / 2.0;
        
        
        // Calculate the pull ratio, between 0.0-1.0
        var pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0;
        
        // Set the Y coord of the graphics, based on pull distance
        var compassY = pullDistance / 2.0 - compassHeightHalf;
        
        // Calculate the X coord of the graphics, adjust based on pull ratio
        //var compassX = (midX + compassWidthHalf) - (compassWidth * pullRatio);
        var compassX = (screenWidth/2) - compassWidthHalf
        // When the compass and spinner overlap, keep them together
        /*if (fabsf(Float(compassX - spinnerX)) < 1.0) {
            self.isRefreshIconsOverlap = true;
        }*/
        
        // If the graphics have overlapped or we are refreshing, keep them together
        if (self.isRefreshIconsOverlap || self.refreshControl!.refreshing) {
            compassX = midX - compassWidthHalf;
        }
        
        // Set the graphic's frames
        var compassFrame = self.compass_background.frame;
        compassFrame.origin.x = compassX;
        compassFrame.origin.y = compassY;
        
        self.compass_background.frame = compassFrame;
        
        // Set the encompassing view's frames
        refreshBounds.size.height = pullDistance;
        
        self.refreshColorView.frame = refreshBounds;
        self.refreshLoadingView.frame = refreshBounds;
        
        // If we're refreshing and the animation is not playing, then play the animation
        if (self.refreshControl!.refreshing && !self.isRefreshAnimating) {
            self.animateRefreshView()
        }
    
    }
    
    func animateRefreshView() {
        
        // Background color to loop through for our color view
        var colorArray = [UIColor(red: 0.752941176, green: 0.22352941176, blue: 0.16862745098, alpha: 0.9),
        UIColor(red: 0.90588235, green: 0.29803922, blue: 0.23529412, alpha: 0.9),
        UIColor(red: 0.08627451, green: 0.62745098, blue: 0.532, alpha: 0.9),
        UIColor(red: 0.20392157, green: 0.28627451, blue: 0.36862745, alpha: 0.9),
        UIColor(red: 0.60784314, green: 0.34901961, blue: 0.71372549, alpha: 0.9)]
       
        // In Swift, static variables must be members of a struct or class
        struct ColorIndex {
            static var colorIndex = 0
        }
        
        // Flag that we are animating
        self.isRefreshAnimating = true;
        
        UIView.animateWithDuration(
            Double(0.3),
            delay: Double(0.0),
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
                // Rotate the spinner by M_PI_2 = PI/2 = 90 degrees
                self.compass_background.transform = CGAffineTransformRotate(self.compass_background.transform, CGFloat(M_PI_2))
                
                // Change the background color
                self.refreshColorView!.backgroundColor = colorArray[ColorIndex.colorIndex]
                ColorIndex.colorIndex = (ColorIndex.colorIndex + 1) % colorArray.count
            },
            completion: { finished in
                // If still refreshing, keep spinning, else reset
                if (self.refreshControl!.refreshing) {
                    self.animateRefreshView()
                }else {
                    self.resetAnimation()
                }
            }
        )
    }
    
    func resetAnimation() {
        
        // Reset our flags and }background color
        self.isRefreshAnimating = false;
        self.isRefreshIconsOverlap = false;
        self.refreshColorView.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetch(completion: () -> Void) {
        // check data
        completion()
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
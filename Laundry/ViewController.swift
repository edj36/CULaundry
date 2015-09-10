//
//  ViewController.swift
//  Laundry
//
//  Created by Eric Johnson  on 7/7/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import UIKit
import Kanna
            
      

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    
    var dormlist = [Dorms]()
    var tableView:UITableView = UITableView()
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var toPass:String!
    var alsoPass:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select a Dorm"
        let dormHtml = loadHTML("http://m.laundryview.com/lvs.php?s=52")
    
        self.dormlist = loadAreaList(toPass, stop:alsoPass)
        
        var screenSize:CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
    }
    
    /* Transitions to SettingsViewController */
    func settingsButtonAction(sender:UIButton!)
    {
        let vc = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true )
    }
    
    /* Transitions to TipsViewController */
    func tipsButtonAction(sender:UIButton!)
    {
        let vc = TipsViewController(nibName: "TipsViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dormlist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        //cell.textLabel?.text = self.items[indexPath.row]
        var dorm : Dorms
        dorm = dormlist[indexPath.row]
        
        cell.textLabel?.text = dorm.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //let vc = MachinesViewController(nibName: "MachinesViewController", bundle: nil)
        let vc = MachinesViewController()
        var name:String
        var dorm:Dorms
        dorm = dormlist[indexPath.row]
        name = dorm.name
        vc.toPass = name
        navigationController?.pushViewController(vc, animated: true)
    
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
    
    func loadAreaList(start:String, stop:String) ->[Dorms] {
        let html = loadHTML("http://m.laundryview.com/lvs.php?s=52")
        var first = [Dorms]()
        var second = [Dorms]()
        if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
            for link in doc.xpath("//li[@id=\"\(start)\"]/following-sibling::li") {
                first.append(Dorms(name:link.text!))
            }
            if stop != "null" {
                for link in doc.xpath("//li[@id=\"\(stop)\"]/following-sibling::li") {
                    second.append(Dorms(name:link.text!))
                }
            }
            else {
                return first
            }
        }
        var difference: Int
        difference = first.count - second.count
        var slice: Array<Dorms> = Array(first[0..<difference - 1])
        return slice
    }
    
       
}


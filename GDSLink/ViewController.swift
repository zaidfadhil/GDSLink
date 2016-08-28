//
//  ViewController.swift
//  GDSLink
//
//  Created by Zaid Ameer on 8/28/16.
//  Copyright © 2016 Zaid Ameer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     var linksA = [String]()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let myURLString = "https://drive.google.com/file/d/0B1XhqDeOfqG7UWZSaG1ZbFFhSzQ/preview"
        
        if let myURL = NSURL(string: myURLString) {
            
            do {
                let myHTMLString = try String(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
               
                let t = myHTMLString
                

                if let rangeOfZero = t.rangeOfString("plid", options: NSStringCompareOptions.BackwardsSearch) {
                    
                    
                    let suffix = String(t.characters.suffixFrom(rangeOfZero.endIndex))
                    
                    //    print(suffix)
                
                    let input = "\(suffix)"
                    let detector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
                    let matches = detector.matchesInString(input, options: [], range: NSRange(location: 0, length: input.utf16.count))
                    
                    //  print(matches)
                    
                    
                    for match in matches {
                        
                        let url = (input as NSString).substringWithRange(match.range)
                        
                        linksA.append(url)
                        
                        tableView.reloadData()
                        
                    }
                    
                } else {
                    print("noooo")
                }
 
                
            } catch {
                print("Error : \(error)")
            }
        } else {
            print("Error: \(myURLString) doesn't  URL")
        }
        

    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linksA.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = linksA[indexPath.row]
        return cell
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("show", sender: self)
    }
    
    override  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "show") {
            
            let indexPaths = tableView.indexPathForSelectedRow
            // let indexPath = indexPaths![0] as NSIndexPath
            let indexPath = indexPaths! as NSIndexPath
            let detailVC = segue.destinationViewController as! testView
            detailVC.urls = self.linksA[indexPath.row]
            
        }
    }



}


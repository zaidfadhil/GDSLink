//
//  ViewController.swift
//  GDSLink
//
//  Created by Zaid Ameer on 8/28/16.
//  Copyright © 2016 Zaid Ameer. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    var linksA = [String]()

    var streamLink : String!
    
    var first : String!
    
    var secend : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I used This methode to get the HTML from the Web Page
            
        let myURLString = "https://drive.google.com/file/d/0B6cdjKm0M2M-MWQzRjdMblJOX3c/preview"
        
        if let myURL = NSURL(string: myURLString) {
            
            do {
                let myHTMLString = try String(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
               
                let t = myHTMLString
                
                if let rangeOfZero = t.rangeOfString("[\"fmt_stream_map\"", options: NSStringCompareOptions.BackwardsSearch) {
                    
                    let suffix = String(t.characters.suffixFrom(rangeOfZero.endIndex))
                    
                    first = suffix
                    
                  //  print(suffix)
                    if let rangeOne = first.rangeOfString(",[\"fmt_list\"", options: NSStringCompareOptions.BackwardsSearch) {
                        let endffix = String(first.characters.prefixUpTo(rangeOne.startIndex))
                        
                        
                        
                        
                         let v = endffix.stringByReplacingOccurrencesOfString("\"", withString: "")
                        let x = v.stringByReplacingOccurrencesOfString("]", withString: "")
                        
                        
                        secend = x
                        
                        print(x)
                        
                    }
                    
                    theLink()

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
    
    func theLink() {
        
        
        /// /[u]00../g
        
        
     //   let firstElement = linksA.first
        
        let firstElement = secend
    
        let t = firstElement!.stringByReplacingOccurrencesOfString(",35", withString: "")
        
        let deUrl = t.characters.split{$0 == "|"}.map(String.init)
        
        let link = deUrl[1]
        
        // let link = deUrl[0] for high 
        // let link = deUrl[2] for low
        
        // the link needs to be decoded
        
        let i = link.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)

        
        let p = i!.stringByReplacingOccurrencesOfString("%5Cu", withString: "")
        
        
        // you can see how the link should look like here :
        // http://ddecode.com/hexdecoder/?results=d82d4e564eccc1a6b96ee7c5c1e1c3b2
        
        // %252C : ,
        // 003d : =
        // 0026 : &
        
         let re = p.stringByReplacingOccurrencesOfString("003d", withString: "=")
       let w =  re.stringByReplacingOccurrencesOfString("0026", withString: "&")
        let c = w.stringByReplacingOccurrencesOfString("%252C", withString: ",")
        
        print(c)
        
        let r = c
        streamLink = r

        
    }
    @IBOutlet var start: UIButton!
    
    @IBAction func actionB(sender: AnyObject) {
        
        playVideo()
    }
    
    func playVideo() {
        
        print(streamLink)
        
        let url = NSURL(string: streamLink)!
        
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }

    }

    
}




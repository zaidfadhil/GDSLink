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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I used This methode to get the HTML from the Web Page
            
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
                    let matches = detector.matchesInString(input, options: [], range: NSRange(location: 0, length: input.utf8.count))
                    
                    //  print(matches)
                    for match in matches {
                        
                        let url = (input as NSString).substringWithRange(match.range)
                        
                        linksA.append(url)
                        
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
        
        
        
        
        let firstElement = linksA.first
    
        let t = firstElement!.stringByReplacingOccurrencesOfString(",35", withString: "")
        
        let deUrl = t.characters.split{$0 == "|"}.map(String.init)
        
        let link = deUrl[0]
        
        // the link needs to be decoded
        
        print("URL : \(link)")
        
        // you can see how the link should look like here :
        // http://ddecode.com/hexdecoder/?results=d82d4e564eccc1a6b96ee7c5c1e1c3b2
        
        
        
        let regex = try! NSRegularExpression(pattern: "[\\\\][u]00..",
                                             options: NSRegularExpressionOptions.CaseInsensitive)
        let range = NSMakeRange(0, link.characters.count)
//        let modString = regex.stringByReplacingMatchesInString(link,
//                                                               options: [],
//                                                               range: range,
//                                                               withTemplate: "XXX")
//        
       // regex.matchesInString(link, options: [], range: range)
        
        
        print(regex.matchesInString(link, options: [], range: range))

        
        
        
        streamLink = link
        
      //  playVideo()
    }
    
    func playVideo() {
        
        let url = NSURL(string: streamLink)!
        
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }

    }

    
}


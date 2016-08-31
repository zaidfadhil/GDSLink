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
        
        print("---")
        
        
    
         let re = link.stringByReplacingOccurrencesOfString("003d", withString: "=")
        let y = re.stringByReplacingOccurrencesOfString("0026", withString: "&")
        
        print(y)
        
//        let c = y.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        print(c)
        
//        let regex = try! NSRegularExpression(pattern: "[\\\\][u]00..",
//                                             options: NSRegularExpressionOptions.CaseInsensitive)
//        let range = NSMakeRange(0, link.characters.count)
////        let modString = regex.stringByReplacingMatchesInString(link,
////                                                               options: [],
////                                                               range: range,
////                                                               withTemplate: "XXX")
////        
//       // regex.matchesInString(link, options: [], range: range)
//        
//        
//        print(regex.matchesInString(link, options: [], range: range))
        
        // https://r6---sn-nv47ln7s.c.docs.google.com/videoplayback?requiressl\u003dyes\u0026id\u003ddec4b6a250e5365c\u0026itag\u003d22\u0026source\u003dwebdrive\u0026ttl\u003dtransient\u0026app\u003dtexmex\u0026ip\u003d185.143.40.72\u0026ipbits\u003d8\u0026expire\u003d1472558967\u0026sparams\u003drequiressl%2Cid%2Citag%2Csource%2Cttl%2Cip%2Cipbits%2Cexpire\u0026signature\u003d7205FE8A78B40C3A302903366174A161821EF50D.8B3B221DDFF8A05611000F83806A2B92B4ECA05F\u0026key\u003dck2\u0026mm\u003d30\u0026mn\u003dsn-nv47ln7s\u0026ms\u003dnxu\u0026mt\u003d1472544221\u0026mv\u003dm\u0026nh\u003dIgpwcjAyLnNvZjAxKgkxMjcuMC4wLjE\u0026pl\u003d24
        
        //https://r6---sn-nv47ln7s.c.docs.google.com/videoplayback?requiressl=yes&id=dec4b6a250e5365c&itag=22&source=webdrive&ttl=transient&app=texmex&ip=185.143.40.72&ipbits=8&expire=1472558967&sparams=requiressl,id,itag,source,ttl,ip,ipbits,expire&signature=7205FE8A78B40C3A302903366174A161821EF50D.8B3B221DDFF8A05611000F83806A2B92B4ECA05F&key=ck2&mm=30&mn=sn-nv47ln7s&ms=nxu&mt=1472544221&mv=m&nh=IgpwcjAyLnNvZjAxKgkxMjcuMC4wLjE&pl=24

        // 003d = =
        // 0026 = &
        
        
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


//
//  ViewController.swift
//  htmlParserTest
//
//  Created by Zaid Ameer on 8/9/16.
//  Copyright © 2016 Zaid Ameer. All rights reserved.
//

import UIKit
import SwiftString


class ViewController: UIViewController {
    
    var urls : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let t = urls.stringByReplacingOccurrencesOfString(",35", withString: " ")
        
        let fullNameArr = t.characters.split{$0 == "|"}.map(String.init)
        
                let encoded = fullNameArr[0]
                let decoded = encoded.stringByDecodingHTMLEntities

        print("url : \(encoded)")
//        
//        let r = encoded.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        print("this is r : \(r)")
        
//        let o = encoded.decodeHTML()
//        print(o)
        
        
//        let y = e.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
////        
////        print(y)
//       
//        
//        if let yu = y {encoded
//            print(yu.stringByDecodingHTMLEntities)
//        }
        
        
       
//        for char in encoded.unicodeScalars {
//            print("\(char)", terminator: "") //Code Unit of each grapheme cluster for the UFT-16 encoding
//        }
        
      //  let catCharacters: [Character] = ["\u{0043}", "\u{0061}", "\u{0074}", "\u{203C}", "\u{1F431}"] // ["C", "a", "t", "‼", "🐱"]
        
        
//        let data = dataWithHexString("68656c6c6f2c20776f726c64") // <68656c6c 6f2c2077 6f726c64>
//        if let string = String(data: data, encoding: NSUTF8StringEncoding) {
//            print(string) //"hello, world"
//        }
        
        if fullNameArr[0] == decoded {
            print("yes it dose ")
            
            let value0: UInt8 = 0x61
            
            
            let string0 = String(UnicodeScalar(value0)) // a
            print(string0)
            
        } else {
            print("new stuff ")
        }
        
//        let r = urls.componentsSeparatedByString("|")
//        print(r)
    }
    
    func dataWithHexString(hex: String) -> NSData {
        var hex = hex
        let data = NSMutableData()
        while(hex.characters.count > 0) {
            let c: String = hex.substringToIndex(hex.startIndex.advancedBy(2))
            hex = hex.substringFromIndex(hex.startIndex.advancedBy(2))
            var ch: UInt32 = 0
            NSScanner(string: c).scanHexInt(&ch)
            data.appendBytes(&ch, length: 1)
        }
        return data
    }
   

}




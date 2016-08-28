//
//  ViewController.swift
//  htmlParserTest
//
//  Created by Zaid Ameer on 8/9/16.
//  Copyright © 2016 Zaid Ameer. All rights reserved.
//

import UIKit

class testView : UIViewController {
    
    var urls : String!
    
    // test
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let t = urls.stringByReplacingOccurrencesOfString(",35", withString: " ")
        
        let deUrl = t.characters.split{$0 == "|"}.map(String.init)
        
        let encoded = deUrl[0]
        

        print("url : \(encoded)")

    }
    
    

}




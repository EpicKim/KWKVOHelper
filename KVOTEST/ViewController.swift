//
//  ViewController.swift
//  KVOTEST
//
//  Created by wangk on 16/2/2.
//  Copyright © 2016年 wangk. All rights reserved.
//

import UIKit

class SSViewController: UIViewController {
    dynamic var test = 1
    dynamic var two = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.
        self.observe("test", closure: { () -> Void in
            print(self.test)
        })

//        self.observe("two", closure: { () -> Void in
//            print(self.two)
//        })
        test = 2
        test = 34
        test = 444
        
        two = 12141
        two = 32414
        two = 414141
        
        self.removeObserver("test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


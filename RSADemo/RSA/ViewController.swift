//
//  ViewController.swift
//  RSA
//
//  Created by macos on 2018/4/10.
//  Copyright © 2018年 macos. All rights reserved.
//

import UIKit
import GTMBase64

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let encodResult = "大号大大大大大大大大".rsa_encode()
        print(encodResult)

        let decodResult = encodResult.rsa_decode()
        print(decodResult)
    }

    


}


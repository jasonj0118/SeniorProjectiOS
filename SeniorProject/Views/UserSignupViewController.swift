//
//  UserSignupViewController.swift
//  SeniorProject
//
//  Created by Jin Young Jeong on 6/7/18.
//  Copyright © 2018 Patrick Cook. All rights reserved.
//

import UIKit
import Foundation
import SpotifyLogin

class UserSignupViewController: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
    }
    
}

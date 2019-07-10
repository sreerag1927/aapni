//
//  ViewController.swift
//  Aapnigaadi
//
//  Created by sreerag p on 03/07/19.
//  Copyright © 2019 sreerag p. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        self.view.isHidden = true
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.value(forKey: "isSignin") != nil){
            if(UserDefaults.standard.value(forKey: "isSignin") as! Bool){
                self.view.isHidden = false
            }else{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            self.view.isHidden = false
        }
    }
    @IBAction func profileBtnPrsd(_ sender: UIButton) {
    }
    @IBAction func moreBtnPrsd(_ sender: UIButton) {
    }
}


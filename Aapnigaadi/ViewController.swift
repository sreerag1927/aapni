//
//  ViewController.swift
//  Aapnigaadi
//
//  Created by sreerag p on 03/07/19.
//  Copyright © 2019 sreerag p. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class ViewController: UIViewController,UITabBarDelegate {
    @IBOutlet weak var tabBar: UITabBar!
    var tabBarIteam: UITabBarItem!
    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var containerView3: UIView!
    override func viewDidLoad() {
        self.view.isHidden = true
        super.viewDidLoad()
        tabBarIteam = (self.tabBar.items?[0])!
        self.tabBar.selectedItem = tabBarIteam
        
        // selected tab background color
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: self.view.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) , size: tabBarItemSize)
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
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

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.title == "Normal Trip"){
            // self.view.addSubview(<#T##view: UIView##UIView#>)
            self.containerView1.isHidden = false
            self.containerView2.isHidden = true
            self.containerView3.isHidden = true
        }else if(item.title == "Out station"){
            self.containerView1.isHidden = true
            self.containerView2.isHidden = false
            self.containerView3.isHidden = true
            
        }else if(item.title == "Airport Pickup Drop"){
            self.containerView1.isHidden = true
            self.containerView2.isHidden = true
            self.containerView3.isHidden = false
        }
    }
}

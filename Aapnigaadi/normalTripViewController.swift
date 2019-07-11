//
//  normalTripViewController.swift
//  demotabbar
//
//  Created by mac on 11/07/19.
//  Copyright © 2019 Self. All rights reserved.
//

import UIKit

class normalTripViewController: UIViewController {

    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var viceVersaView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var carouselView: UIView!
    override func viewDidLoad() {
          let nc = NotificationCenter.default
                nc.addObserver(self, selector: #selector(printValue), name: NSNotification.Name(rawValue: "printValue3"), object: nil)
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    @objc func printValue(notification:NSNotification) {
        let userInfo:[String:Any] = notification.userInfo as! [String:Any]
        let item = userInfo["value"]! as! String
        dateBtn.setTitle(item, for: .normal)
    }
    func setUp(){
        self.fromView.layer.cornerRadius = 15
        self.fromView.layer.masksToBounds = true
        self.toView.layer.cornerRadius = 15
        self.toView.layer.masksToBounds = true
       // self.viceVersaView.layer.cornerRadius = self.viceVersaView.frame.height / 2
       // self.viceVersaView.layer.masksToBounds = true
        self.searchBtn.layer.cornerRadius = self.searchBtn.frame.height / 2
        self.searchBtn.layer.masksToBounds = true
//        self.viceVersaView.layer.shadowColor = UIColor.black.cgColor
//        self.viceVersaView.layer.shadowOpacity = 0.3
//        self.viceVersaView.layer.shadowRadius = 5
//        self.viceVersaView.layer.shadowOffset = CGSize(width: 3, height: -4)
        self.carouselView.layer.cornerRadius = 10
        self.carouselView.layer.masksToBounds = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM, hh:mm"
        let dateStr = Date()
        let strDate = dateFormatter.string(from: dateStr)
         dateBtn.setTitle(strDate, for: .normal)
    }
    @IBAction func dateBtnPrsd(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "dateViewController") as! dateViewController
        nextViewController.willMove(toParent: self)
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.bounds;
        self.view.addSubview(nextViewController.view)
        nextViewController.didMove(toParent: self)
    }
    @IBAction func searchBtnPrsd(_ sender: UIButton) {
        print("search pressed")
    }
    @IBAction func viceVersaBtnPrsd(_ sender: UIButton) {
        let to:String = self.toLabel.text!
        self.toLabel.text = self.fromLabel.text!
        self.fromLabel.text = to
    }
    
}

//
//  dateViewController.swift
//  demotabbar
//
//  Created by mac on 11/07/19.
//  Copyright © 2019 Self. All rights reserved.
//

import UIKit

class dateViewController: UIViewController {
    var dateTime:String!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func okBtnPrsd(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM, hh:mm"
       // dateFormatter.dateStyle = DateFormatter.Style.full
        //dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateTime = strDate
        print(dateTime!)
        self.removeFromParent()
        self.view.removeFromSuperview()
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "printValue3"), object: nil, userInfo: ["value" : dateTime!])
    }
    @IBAction func cancelBtnPrsd(_ sender: UIButton) {
        self.removeFromParent()
        self.view.removeFromSuperview()
        let nc = NotificationCenter.default
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM, hh:mm"
        let dateStr = Date()
        let strDate = dateFormatter.string(from: dateStr)
        nc.post(name: NSNotification.Name(rawValue: "printValue3"), object: nil, userInfo: ["value" : strDate])
    }
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateTime = strDate
    }
  

}

//
//  BaseViewController.swift
//  Copyright © 2018 sreerag. All rights reserved.
//

//defaults
    // AccessToken = (forKey: "accessToken")
    // TokenType = (forKey: "tokenType")
    // sign in = (forKey: "isSignin") 

import UIKit
let BASE_URL = "https://aapnigaadi.tnmos.com/public/api.customer"
let REGISTER = "/auth/register"
let LOGIN = "/auth/login"
class BaseViewController: UIViewController {
    var activityInd:UIActivityIndicatorView!
    let smallView:UIView = UIView()
    let largeView:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        smallView.isHidden = true
        self.largeView.frame = self.view.frame
        smallView.frame = CGRect(x:self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2, width: 60, height: 60)
        smallView.center = self.view.center
        smallView.layer.cornerRadius = 12
        smallView.backgroundColor = UIColor.gray
         largeView.backgroundColor = UIColor.clear
        if (activityInd == nil) {
            activityInd = UIActivityIndicatorView.init()
        }
        activityInd.frame = CGRect(x:0, y: 0, width: 60, height:60)
        activityInd.style = .whiteLarge
        smallView.addSubview(activityInd)
        self.largeView.addSubview(smallView)
       // self.view.addSubview(largeView)
    }
    override func viewDidLayoutSubviews() {
        largeView.frame = self.view.bounds
        smallView.frame = CGRect(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2, width: 60, height: 60)
        smallView.center = self.view.center
        activityInd.frame = CGRect(x:0, y: 0, width: 60, height:60)
    }
    func showLoading()  {
        self.view.addSubview(largeView)
        largeView.isHidden = false
        smallView.isHidden = false
        activityInd.isHidden = false
        activityInd.startAnimating()
    }

    func hideLoading()  {
        largeView.isHidden = true
        smallView.isHidden = true
        activityInd.isHidden = true
        activityInd.stopAnimating()
        largeView.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func isValideEmail(enteredEmail:String) -> Bool{
        let emailFormat = "^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]{1}|[\\w-]{2,}))@" + "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?" + "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\." + "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?" + "[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|" + "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let result = emailPredicate.evaluate(with: enteredEmail)
        return result
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

//
//  loginViewController.swift
//  Aapnigaadi
//
//  Created by sreerag p on 09/07/19.
//  Copyright © 2019 sreerag p. All rights reserved.
//

import UIKit
import Alamofire
@available(iOS 10.0, *)
class loginViewController: BaseViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    var users:user!
    var activeTextField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    func setUp(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        self.emailView.layer.cornerRadius = self.emailView.frame.height / 2
        self.emailView.layer.masksToBounds = true
        self.passwordView.layer.cornerRadius = self.passwordView.frame.height / 2
        self.passwordView.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.height / 2
        self.loginBtn.layer.masksToBounds = true
        self.signUpBtn.layer.borderWidth = 1.5
        self.signUpBtn.layer.borderColor = UIColor.white.cgColor
        self.signUpBtn.layer.cornerRadius = self.signUpBtn.frame.height / 2
        self.signUpBtn.layer.masksToBounds = true
    }

    func  login(){
        self.showLoading()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        let params:Parameters = ["email":self.emailField.text!,"password":self.passwordField.text!]
        let url = BASE_URL + LOGIN
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                self.hideLoading()
                if let data = response.result.value{
                    let dic:[String:Any] = data as! [String:Any]
                    print(dic)
                    if(dic["access_token"] != nil){
                        let accessToken:String = dic["access_token"] as! String
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                        let tokenType:String = dic["token_type"] as! String
                        UserDefaults.standard.set(tokenType, forKey: "tokenType")
                        let userDic:[String:Any] = dic["user"] as! [String:Any]
                        self.users = user(dic: userDic)
                        UserDefaults.standard.set(true, forKey: "isSignin")
                        UserDefaults.standard.synchronize()
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Home") as! ViewController
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        if(dic["message"] != nil){
                            //  var msg:?tring = dic["messsage"] as! String
                            let alert = UIAlertController(title: "Error", message: dic["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (al) in
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(_):
                self.hideLoading()
                print(response.result.error!)
                let alert = UIAlertController(title: "Error", message: response.result.error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (al) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
                break
                
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if((activeTextField) != nil){
            activeTextField.resignFirstResponder()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){}
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>){}
    @IBAction func forgotPassBtnPrsd(_ sender: UIButton) {
    }
    @IBAction func logInBtnPrsd(_ sender: UIButton) {
        if(self.emailField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Email field cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (al) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }else if(self.passwordField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Password field cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (al) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.login()
        }
    }
    @IBAction func signUpBtnPrsd(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerViewController") as! registerViewController
        self.present(vc, animated: true, completion: nil)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        var userInfo = sender.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.scroll_view.contentInset
        contentInset.bottom = keyboardFrame.size.height  //Set this value (30) according to your code as i have navigation tool bar for next and prev.
        self.scroll_view.contentInset = contentInset
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scroll_view.contentInset = contentInset
    }
  
}
@available(iOS 10.0, *)
extension loginViewController:UITextFieldDelegate{
    public func textFieldDidBeginEditing(_ textField: UITextField){
        activeTextField = textField
        textField.becomeFirstResponder()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField){
        activeTextField = nil
        if(textField == self.emailField && (self.emailField.text!) != ""){
            if(self.emailField.text != nil){
                let result = isValideEmail(enteredEmail:emailField.text!)
                if(result == false){
                        let msgStr = "Enter correct Email id"
                        let alert = UIAlertController(title: "", message: msgStr, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            textField.resignFirstResponder()
        }
    }
}



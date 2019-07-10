//
//  registerViewController.swift
//  Aapnigaadi
//
//  Created by sreerag p on 04/07/19.
//  Copyright © 2019 sreerag p. All rights reserved.
//

import UIKit
import Alamofire
class registerViewController: BaseViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var mobileImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var MobileNumberView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var emailIdView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    // variables
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
        self.userNameView.layer.cornerRadius = self.userNameView.frame.height / 2
        self.userNameView.layer.masksToBounds = true
        self.emailIdView.layer.cornerRadius = self.emailIdView.frame.height / 2
        self.emailIdView.layer.masksToBounds = true
        self.MobileNumberView.layer.cornerRadius = self.MobileNumberView.frame.height / 2
        self.MobileNumberView.layer.masksToBounds = true
        self.submitBtn.layer.cornerRadius = self.submitBtn.frame.height / 2
        self.passwordView.layer.cornerRadius = self.confirmPasswordView.frame.height / 2
        self.passwordView.layer.masksToBounds = true
        self.confirmPasswordView.layer.cornerRadius = self.confirmPasswordView.frame.height / 2
        self.confirmPasswordView.layer.masksToBounds = true
    }
    @IBAction func submitBtnprsd(_ sender: UIButton) {
        var password:String = self.passwordFld.text!
        if(self.userNameField.text! == ""){
                let alert = UIAlertController(title: "", message: "Please enter your name", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else if(self.emailField.text! == ""){
                let alert = UIAlertController(title: "", message: "Please enter your email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else if(self.passwordFld.text! == ""){
                let alert = UIAlertController(title: "", message: "Please enter your password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else if(self.passwordFld.text!.count < 8){
                let alert = UIAlertController(title: "", message: "Use 8 characters or more for your password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else if(password.popLast() == " " || Array(self.passwordFld.text!)[0] == " "){
                let alert = UIAlertController(title: "", message: "Password should not be start or end with space", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else if(self.passwordFld.text! != self.confirmPasswordField.text!){
            let alert = UIAlertController(title: "", message: "Passsword missmatch", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.registerUser()
        }
    }
    
    func registerUser(){
        self.showLoading()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        let params:Parameters = ["name":self.userNameField.text!,"email":self.emailField.text!,"phone":self.mobileField.text!,"password":self.passwordFld.text!,"password_confirmation":self.confirmPasswordField.text!]
         let url = BASE_URL + REGISTER
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
                        UserDefaults.standard.set(true, forKey: "isSignin")
                        UserDefaults.standard.synchronize()
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Home") as! ViewController
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        if(dic["message"] != nil){
                          //  var msg:String = dic["messsage"] as! String
                            let alert = UIAlertController(title: "Error", message: (dic["message"] as! String), preferredStyle: UIAlertController.Style.alert)
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
extension registerViewController:UITextFieldDelegate{
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
extension registerViewController:UIGestureRecognizerDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if((activeTextField) != nil){
            activeTextField.resignFirstResponder()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){}
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>){}
    
}

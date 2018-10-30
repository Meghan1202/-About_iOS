//
//  ViewController.swift
//  ProjectD22
//
//  Created by Praneet  on 9/30/18.
//  Copyright © 2018 Praneet . All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var status: UILabel!
   var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInButton.isEnabled = false
        ref = Database.database().reference()
    }

    
    @IBAction func info(_ sender: Any) {
        let alert = UIAlertController(title: " Info", message: "Make sure your emailID doesn't have any special charecters. Developed by Apples!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: Any) {
        if let tusern = username.text as String?{
            if let tpass = password.text as String?{
                Auth.auth().signIn(withEmail: tusern, password: tpass, completion: {(user,error) in if error != nil {self.status.text = "Can't sign in"}
                else{
                    self.status.text = "Sign in successful"
                    self.username.text = ""
                    self.password.text = ""
                    self.status.text = "Logged Out"
                    self.signInButton.isEnabled = false
                    self.performSegue(withIdentifier: "login", sender: self)
                    }
                })
            }
        }
    }
    
    @IBOutlet weak var signInButton: UIButton!
    
    func appendTo(tempVal:String){
        self.data.append(tempVal)
        print("value : \(tempVal), \(self.data.count) \(self.data)")
    }
    
    func fetchData(){
        
        var useref = username.text?.replacingOccurrences(of: "@", with: "")
        useref = useref?.replacingOccurrences(of: ".com", with: "")
        print(useref)
        ref.child("entries").child(useref!).observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as? NSDictionary
            for(key,value) in dict!{
                self.appendTo(tempVal: value as! String)
            }
            self.signInButton.isEnabled = true
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func preSignIn(_ sender: Any) {
        if let tusern = username.text as String?{
            if let tpass = password.text as String?{
                Auth.auth().signIn(withEmail: tusern, password: tpass, completion: {(user,error) in if error != nil {self.view.endEditing(true)}
                else{
                        self.view.endEditing(true)
                    self.fetchData()
                    }
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
        let destinationVC = segue.destination as! meTableTableViewController
        if let tusern = username.text as String?{
            if let tpass = password.text as String?{
                destinationVC.Username = tusern
                destinationVC.Password = tpass
                destinationVC.data = data
                data = []
                }
            }
        }
    }
    
   
    
    @IBAction func signUp(_ sender: Any) {
        if let tusern = username.text as String?{
            
            if let tpass = password.text as String?{
                var useref = tusern.replacingOccurrences(of: "@", with: "")
                useref = useref.replacingOccurrences(of: ".com", with: "")
                Auth.auth().createUser(withEmail: tusern, password: tpass, completion: {(user, error) in if error != nil {
                     self.status.text = "Can't Register"
                }
                else {
                    self.status.text =  "Sign up successful"
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy"
                    let result = formatter.string(from: date)
                    self.ref.child("entries/\(useref)/").childByAutoId().setValue("#StartedOnthisday-> \(result)")
                    }})
            }
        }
    }
    
}


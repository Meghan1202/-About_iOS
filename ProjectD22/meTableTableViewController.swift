//
//  meTableTableViewController.swift
//  ProjectD22
//
//  Created by Praneet  on 9/30/18.
//  Copyright © 2018 Praneet . All rights reserved.
//

import UIKit
import Firebase

class meTableTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var Username:String = ""
    var Password:String = ""
    var data: [String] = []
    @IBOutlet weak var connectField: UITextField!
    @IBOutlet weak var searchField: UITextField!
    override func viewDidLoad() {
         ref = Database.database().reference()
        Auth.auth().signIn(withEmail: Username, password: Password, completion: {(user,error) in if error != nil{print("Error")}
        else{
     
            }
        })
   
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source
    
    func appendTo(tempVal:String){
        self.data.append(tempVal)
        print("value : \(tempVal), \(self.data.count) \(self.data)")
    }
    
    
   
    
    @IBAction func logOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            data = []
            self.dismiss(animated: true, completion: {self.navigationController?.popToRootViewController(animated: true)})
            
        }catch{
            data = []
            self.dismiss(animated: true, completion: {self.navigationController?.popToRootViewController(animated: true)})
        }
    }
    
    @IBAction func searchUser(_ sender: Any)
    {
        var useref = Username.replacingOccurrences(of: "@", with: "")
        useref = useref.replacingOccurrences(of: ".com", with: "")
        if searchField.text != nil{
            
            ref.child("entries/\(useref)/").childByAutoId().setValue(searchField.text as! String)
            data.append(searchField.text as! String)
            tableView.reloadData()
            tableView.endUpdates()
            self.view.endEditing(true)
    }

        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return(data.count)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 60
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        var col =  UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        cell.contentView.backgroundColor = col
        cell.textLabel?.backgroundColor = col
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

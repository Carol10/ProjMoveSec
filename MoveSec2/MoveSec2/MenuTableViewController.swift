//
//  MenuTableViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 20/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase

class MenuTableViewController: UITableViewController {

    var como = " "
    var connect = "Desconectado"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(handleLogOut))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        checkUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkUser() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        }else{
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("Users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any]{
                    self.como = (dictionary["NLD"] as? String)!
                    self.connect = (dictionary["conexao"] as? String)!
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            
            })
        }
    }
    
    func handleLogOut() {
        do{
            try FIRAuth.auth()?.signOut()
            print("Logout Efetuado!")
            performSegue(withIdentifier: "VaiLogout", sender: self)
        } catch let logoutError{
            print(logoutError)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! DispTableViewCell
        

        // Configure the cell...
        if indexPath.row == 1 {
            cell.addImage.image = UIImage(named: "add")
            cell.textLabel?.backgroundColor = UIColor(colorLiteralRed: 241.0, green: 250.0, blue: 237.0, alpha: 1.0)
        }else{
            if connect == "Desconectado" {
                cell.ballImage.image = UIImage(named: "RedBall")
                cell.comodo.text = como
                cell.textLabel?.backgroundColor = UIColor(colorLiteralRed: 241.0, green: 250.0, blue: 237.0, alpha: 1.0)
            }else{
                cell.ballImage.image = UIImage(named: "GreenBall")
                cell.comodo.text = como
                cell.textLabel?.backgroundColor = UIColor(colorLiteralRed: 241.0, green: 250.0, blue: 237.0, alpha: 1.0)
            }
            
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            performSegue(withIdentifier: "VaiAdd", sender: self)
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

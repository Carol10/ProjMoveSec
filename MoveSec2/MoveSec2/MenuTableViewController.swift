//
//  MenuTableViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 20/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class MenuTableViewController: UITableViewController {

    var como = " "
    var connect = "Desconectado"
    var inv = " "
    var aux = " "
    
    var data = " "
    var codD = " "
    var nome = " "
    var email = " "
    var descricao = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(handleLogOut))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "User", style: .plain, target: self, action: #selector(irStatus))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
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
            
            FIRDatabase.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let dic = snapshot.value as? [String:Any]{
                    self.inv = (dic["Ninvasoes"] as? String)!
                    self.nome = (dic["nome"] as? String)!
                    self.email = (dic["email"] as? String)!
                    self.data = (dic["dataUI"] as? String)!
                    self.codD = (dic["codD"] as? String)!
                    //self.connect = (dic["conexao"] as? String)!
                    self.como = (dic["NLD"] as? String)!
                    self.descricao = (dic["Descricao"] as? String)!
                    
                  //  let values = ["nome": self.nome, "email": self.email, "NLD" : self.como, "codD" : self.codD, "dataUI" : self.data, "Ninvasoes" : self.inv, "conexao" : "Desconectado", "Descricao" : self.descricao]
                    
                   // FIRDatabase.database().reference().child("Users").child(uid!).setValue(values)
                }
            
            })
            
            
            FIRDatabase.database().reference().child("Users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any]{
                    self.como = (dictionary["NLD"] as? String)!
                    self.connect = (dictionary["conexao"] as? String)!
                    self.aux = (dictionary["Ninvasoes"] as? String)!
                    
                    if(self.aux != self.inv){
                        self.inv = self.aux
                        
                        DispatchQueue.main.async {
                            self.localNot()
                        }
                    }

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            
            })
        }
    }
    
    func localNot() {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "Legal"
        content.title = "Alerta de Invasão!"
        content.body = "Alerta de movimentação proxima ao dipositivo instalado em \(self.como)"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "Now", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request, withCompletionHandler: {(er) in
            print("erro not: \(er)")
        })
        
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
    
    func irStatus() {
        performSegue(withIdentifier: "VaiStatus", sender: self)
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

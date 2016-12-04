//
//  AddDispViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 20/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AddDispViewController: UIViewController {
    @IBOutlet weak var codField: UITextField!

    @IBOutlet weak var comodoField: UITextField!
    
    @IBOutlet weak var addDisp: UIButton!
    
    var como = " "
    var codD = " "
    var connect = " "
    var invasoes = " "
    var data = " "
    var email = " "
    var nome = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = UIColor.black
        codField.placeholder = "Ex: 106784"
        comodoField.placeholder = "Ex: Cozinha"
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDispAct(_ sender: Any) {
        guard let cod = codField.text, let comodo = comodoField.text else
        {
            print("valores inválidos!")
            return
        }
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSegue(withIdentifier: "VoltaMenu", sender: self)
            return
        }else{
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("Users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any]{
                    //self.como = (dictionary["NLD"] as? String)!
                    self.connect = (dictionary["conexao"] as? String)!
                    //self.codD = (dictionary["codD"] as? String)!
                    self.connect = (dictionary["conexao"] as? String)!
                    self.invasoes = (dictionary["Ninvasoes"] as? String)!
                    self.data = (dictionary["dataUI"] as? String)!
                    self.email = (dictionary["email"] as? String)!
                    self.nome = (dictionary["nome"] as? String)!
                    
                    let values = ["nome": self.nome, "email": self.email, "NLD" : comodo, "codD" : cod, "dataUI" : self.data, "Ninvasoes" : self.invasoes, "conexao" : self.connect]
                    FIRDatabase.database().reference().child("Users").child(uid!).setValue(values)
                }
                
            })
            
            
            
        }
        
        performSegue(withIdentifier: "VoltaMenu", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

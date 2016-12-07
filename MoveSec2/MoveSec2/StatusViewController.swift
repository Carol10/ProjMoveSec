//
//  StatusViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 04/12/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase

class StatusViewController: UIViewController {

    @IBOutlet weak var invasoes: UILabel!
    
    @IBOutlet weak var data: UILabel!
    
    var aux = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = UIColor.black
        
        getDados()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDados() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            print("Erro ao pegar dados.")
            return
        }else{
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            FIRDatabase.database().reference().child("Users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:Any]{
                    self.navigationItem.title = (dictionary["nome"] as? String)!
                    self.invasoes.text = (dictionary["Ninvasoes"] as? String)!
                    self.data.text = (dictionary["dataUI"] as? String)!
                    
                }
                
            })
        }
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

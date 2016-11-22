//
//  CadastroViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 20/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CadastroViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var senhaField: UITextField!
    @IBOutlet weak var nomeField: UITextField!
    @IBOutlet weak var cadastrar: UIButton!
    @IBOutlet weak var sair: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.placeholder = "exemplo@email.com"
        nomeField.placeholder = "Ex: Lucas"
        senhaField.isSecureTextEntry = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cadastrarAct(_ sender: Any) {
        guard let emailc = emailField.text, let senhac = senhaField.text else {
            print("valores inválidos!")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: emailc, password: senhac, completion: { (user: FIRUser?, error) in
            if error != nil {
                print("Cadastro Não Efetuado!")
                return
            }else{
                print("Cadastro Efetuado!")
                self.performSegue(withIdentifier: "VaiInicio", sender: self)
                return
            }
        })
        
    }
    @IBAction func sairAct(_ sender: Any) {
        performSegue(withIdentifier: "VaiInicio", sender: self)
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

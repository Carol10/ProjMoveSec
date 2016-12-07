//
//  ViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 19/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var senhaField: UITextField!
    @IBOutlet weak var entrar: UIButton!
    @IBOutlet weak var cadastrar: UIButton!
    @IBOutlet weak var appIcone: UIImageView!
    
    var e = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.isNavigationBarHidden = true
        
        emailField.placeholder = "exemplo@email.com"
        senhaField.isSecureTextEntry = true
        
        emailField.delegate = self
        senhaField.delegate = self
        
        appIcone.image = UIImage(named: "TelaInicial")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func entrarAct(_ sender: Any) {
        guard let emailc = emailField.text, let senhac = senhaField.text else {
            print("valores inválidos!")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: emailc, password: senhac, completion: { (user: FIRUser?, error) in
            if error != nil {
                print("Login Não Efetuado!")
                return
            }else{
                print("Login Efetuado!")
                self.performSegue(withIdentifier: "VaiLogin", sender: self)
                return
            }
        })
        
        
    }

    @IBAction func cadastrarAct(_ sender: Any) {
        performSegue(withIdentifier: "VaiCadastro", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailField.resignFirstResponder()
        self.senhaField.resignFirstResponder()
        return true
    }

}


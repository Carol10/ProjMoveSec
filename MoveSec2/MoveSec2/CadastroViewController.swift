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

class CadastroViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var senhaField: UITextField!
    @IBOutlet weak var nomeField: UITextField!
    @IBOutlet weak var cadastrar: UIButton!
    @IBOutlet weak var sair: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.placeholder = "exemplo@email.com"
        senhaField.placeholder = "pelo menos 6 dígitos."
        nomeField.placeholder = "Ex: Lucas"
        senhaField.isSecureTextEntry = true
        
        senhaField.delegate = self
        emailField.delegate = self
        nomeField.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cadastrarAct(_ sender: Any) {
        guard let emailc = emailField.text, let senhac = senhaField.text, let nomec = nomeField.text else
        {
            print("valores inválidos!")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: emailc, password: senhac, completion: { (user: FIRUser?, error) in
            if error != nil {
                print("Cadastro Não Efetuado!")
                return
            }
            
            //cadastro efetuado com sucesso!
            guard let uid = user?.uid else{
                return
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://movesec2-83125.firebaseio.com/")
            let usersReference = ref.child("Users").child(uid)
            
            let values = ["nome": nomec, "email": emailc, "NLD" : "Sem dispositivos.", "codD" : "0", "dataUI" : "Sem data.", "Ninvasoes" : "0", "conexao" : "Desconectado", "Descricao" : " "]
            
            usersReference.updateChildValues(values, withCompletionBlock: {
                (err,ref) in
                
                if err != nil{
                    print("erro no Database")
                    return
                }
                print("usuario salvo no database!")
            
            })
            
            print("Cadastro Efetuado!")
            self.performSegue(withIdentifier: "VaiInicio", sender: self)
            
        })
        
    }
    @IBAction func sairAct(_ sender: Any) {
        performSegue(withIdentifier: "VaiInicio", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.senhaField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.nomeField.resignFirstResponder()
        return true;
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

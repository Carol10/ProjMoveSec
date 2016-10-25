//
//  ViewController.swift
//  MoveSec
//
//  Created by Ana Caroline Saraiva Bezerra on 18/10/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadastro: UIButton!
    @IBOutlet weak var entrar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func TelaCadastro(_ sender: AnyObject) {
        performSegue(withIdentifier: "VaiCadastro", sender: self)
    }

    @IBAction func TelaLogin(_ sender: AnyObject) {
        performSegue(withIdentifier: "VaiLogin", sender: self)
    }
}


//
//  AddDispViewController.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 20/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit

class AddDispViewController: UIViewController {
    @IBOutlet weak var codField: UITextField!

    @IBOutlet weak var comodoField: UITextField!
    
    @IBOutlet weak var addDisp: UIButton!
    
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

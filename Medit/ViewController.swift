//
//  ViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 20/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Vue principale de MEDIT

    @IBAction func About(_ sender: Any) {
        let alertApropos = UIAlertController(title: "A propos", message: "Appli réalisée par dans le cadre de ma formation \n Le code source est libre et accessible sur GitLab @bebone", preferredStyle: UIAlertControllerStyle.alert)
        alertApropos.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertApropos, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }


}


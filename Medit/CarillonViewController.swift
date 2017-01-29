//
//  CarillonViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 24/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit

class CarillonViewController: UIViewController {
    //TO DO J'aimerais utiliser le gyroscope pour lancer la musique !!!!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Carillon"
        let alertSave = UIAlertController(title: "Secouez :-) !", message: "Basculez l'iPhone ou l'iPad pour lancer la musique !", preferredStyle: UIAlertControllerStyle.alert)
        alertSave.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertSave, animated: true, completion: nil)

           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

//
//  SeanceViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 20/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit

class SeanceViewController: UIViewController {

   
    @IBOutlet weak var stepperGong: UIStepper!
    @IBOutlet weak var buttonDemarrer: UIButton!
    @IBOutlet weak var stepperMinutes: UIStepper!
    @IBOutlet weak var labelMinutes: UILabel!
    @IBOutlet weak var gongSwitch: UISwitch!
    @IBOutlet weak var infoSon: UILabel!
    @IBOutlet weak var labelMinutesGong: UILabel!
    @IBOutlet weak var labelMinutesGongdesc: UILabel! // correspond au label "min" du Gong
    var timerStart: Bool! = false
    
    

    
    
    @IBAction func activeGong(_ sender: UISwitch) {
        if (gongSwitch.isOn) {
            infoSon.isHidden=false
            labelMinutesGong.isHidden=false
            labelMinutesGongdesc.isHidden=false
            stepperGong.isHidden=false
            }
        else {
            infoSon.isHidden=true
            labelMinutesGong.isHidden=true
            stepperGong.isHidden=true
            labelMinutesGongdesc.isHidden=true
            labelMinutesGong.text="0" //On remet les minutes à 0 car c'est desactivé
        }
    }
    
    
    @IBAction func changeMinute(_ sender: UIStepper) {
        labelMinutes.text = Int(sender.value).description
        let minutes:Int? = Int(labelMinutes.text!)
        if (minutes!>0 && Int(labelMinutesGong.text!)! < minutes! ) {
            buttonDemarrer.isEnabled=true //Aller à la prochaine vue
        }
        else {
            buttonDemarrer.isEnabled=false // Empêcher l'accès car 0 minute
        }
    }
    
    
    @IBAction func changeMinuteGong(_ sender: UIStepper) {
        labelMinutesGong.text = Int(sender.value).description
        
        if(Int(labelMinutes.text!)!>0 && Int(labelMinutesGong.text!)!<Int(labelMinutes.text!)!) {
            buttonDemarrer.isEnabled=true
        }
            else {
             buttonDemarrer.isEnabled=false
            
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title="Séance"
        stepperMinutes.wraps = true
        stepperMinutes.autorepeat = true
        stepperMinutes.maximumValue = 60
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VersSeanceProgress") {
            let destination = segue.destination as! SeanceProgressViewController //référence
            destination.minutesRecue = labelMinutes.text
            destination.minutesGongRecue = labelMinutesGong.text
            if (timerStart==false) {
            destination.startSeance = true //On lance une séance avec une instance de Timer
            }
        }
    }

}

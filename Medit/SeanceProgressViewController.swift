//
//  SeanceProgressViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 20/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit
import AVFoundation

class SeanceProgressViewController: UIViewController {
    
    // Récupération des variables Minutes via Segue
    var minutesRecue: String!
    var minutesGongRecue: String!
    
    // Déclarations
    @IBOutlet weak var boutonRetour: UIButton!
    @IBOutlet weak var ecrireCarnetB: UIButton!
    @IBOutlet weak var ecrireCarnetL: UILabel!
    @IBOutlet weak var seanceProgress: UILabel!
    @IBOutlet weak var minutesSeance: UILabel!
    var timer:Timer = Timer() // Info : Un timer ne peux pas être mis en pause
    let synthetiseur = AVSpeechSynthesizer()
    var monText = AVSpeechUtterance(string:"")
    var tempsPasse:Int = 0
    var lecteur = AVAudioPlayer()
    var startSeance: Bool!
    var luminositeUser: Float = Float(UIScreen.main.brightness) //réglages initiaux de luminosité
    

    
    /*DEMARRAGE SEANCE*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //On surcharge le bouton Back du NavigationController,car nous souhaitons appliquer une action lors du click sur le bouton (l'arrêt du timer)
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Revenir en arrière", style: UIBarButtonItemStyle.plain, target: self, action: #selector(stop))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        tempsPasse = (Int(minutesRecue)!)*60 //on passe en secondes
        compteur()
        parler(texte: "Début de séance")
        //On baisse la luminosité pour détendre ses petits yeux :-)
        UIScreen.main.brightness = CGFloat(0.1)
   }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        
    }
    
    func stop() {
        timer.invalidate() // on retourne sur la view précedente, on stoppe le timer
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func minuteurString(temps:Int)-> String  {
        let heure = Int(temps) / 3600
        let minutes = Int(temps) / 60 % 60
        let secondes = Int(temps) % 60
        
        return String(format: "%02i:%02i:%02i", heure, minutes, secondes)
    }
    
    
    func compteur() {
        if (startSeance == true) {
        startSeance = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incrementation), userInfo: nil, repeats: true)
        timer.fire() //démarrage du timer
        }
    }
    
    
    func incrementation() {
        if (tempsPasse == 0) {
            /*FIN DE SEANCE*/
            timer.invalidate() //Arret du timer à 0
            gong()
            seanceProgress.text = "Séance terminée !"
            UIScreen.main.brightness = CGFloat(luminositeUser) //On remet la luminosité normale
            /*Display des éléments cachés */
            ecrireCarnetB.isHidden = false
            ecrireCarnetL.isHidden = false
            boutonRetour.isHidden = false
            startSeance = true
            
            
        }
        else {
            tempsPasse -= 1
            minutesSeance.text = minuteurString(temps: tempsPasse)
        }
        
    }
    
    
    func gong() {
        //On lance le Gong audio lors de la fin de séance
        do {
            lecteur = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gong", ofType: "mp3")!))
            lecteur.prepareToPlay()
            lecteur.play()
        } catch {
            print("erreur lecture ficher MP3")
        }
    }
    
    func parler(texte: String) {
        monText.voice = AVSpeechSynthesisVoice(language: "fr-FR") //On force l'usage du français
        monText = AVSpeechUtterance(string:texte)
        monText.rate = 0.4 // Vitesse de la voix
        synthetiseur.speak(monText)
    }
    
   
}





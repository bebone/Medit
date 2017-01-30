//
//  CarillonViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 24/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class CarillonViewController: UIViewController {
    //TO DO J'aimerais utiliser le gyroscope pour lancer la musique !!!!
    // Avec l'aide de http://theswiftguy.com/index.php/2016/12/19/how-to-use-the-accelerometer-in-xcode-8-swift-3-0/
    
    var motionManager = CMMotionManager() //instancie le Manager
    var lecteur = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title="Carillon"
        let alertSave = UIAlertController(title: "Secouez :-) !", message: "Basculez l'iPhone ou l'iPad pour lancer la musique !", preferredStyle: UIAlertControllerStyle.alert)
        alertSave.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertSave, animated: true, completion: nil)

    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.accelerometerUpdateInterval = 0.3
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data // si on réussit à lre les données
            {
                if myData.acceleration.x > 4
                {
                    print ("DO SOMETHING SPCIAL")
                    do {
                        self.lecteur = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "carillon", ofType: "mp3")!))
                        self.lecteur.prepareToPlay()
                        self.lecteur.play()
                    } catch {
                        print("erreur lecture ficher MP3")
                    }

                    
                }
            }
        }
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

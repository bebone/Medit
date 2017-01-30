//
//  CarnetAjoutViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 20/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit

class CarnetAjoutViewController: UIViewController {

    
    @IBOutlet weak var titreTextfield: UITextField!
        
    @IBOutlet weak var contenuTextView: UITextView!
    var fileManager = FileManager()
    var temporaryDirectory = NSTemporaryDirectory()
    let currentDateTime = Date()
    
 //aide précieuse à retrouver http://stackoverflow.com/questions/24097826/read-and-write-data-from-text-file

    @IBAction func enregistrerBouton(_ sender: UIButton) {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        
        // Le nom que l'on attribue au fichier : le titre de l'article + la date du jour
        let fileName = titreTextfield.text!+" "+formatter.string(from: currentDateTime)
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        //on applique l'extension txt
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            
            //
            let outString = contenuTextView.text!
            do {
                print(fileURL) // pour le debug, affichage de l'URL
                try outString.write(to: fileURL, atomically: true, encoding: .utf8)
                let alertSave = UIAlertController(title: "Article Enregistré !", message: "Article enregistré avec succès dans votre carnet!", preferredStyle: UIAlertControllerStyle.alert)
                alertSave.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                    print("Debug")
                    _ = self.navigationController?.popViewController(animated: true)
                   
                    
                                   }))
                //
                
                self.present(alertSave, animated: true, completion: nil)

            } catch {
                print("Ecriture impossible: \(fileURL), Erreur: " + error.localizedDescription)
            }
            
            // lecture du fichier pour debug
            var inString = ""
            do {
                inString = try String(contentsOf: fileURL)
            } catch {
                print("Impossible de lire l' URL: \(fileURL), Error: " + error.localizedDescription)
            }
            print("Read from file: \(inString)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func textViewDidBeginEditing(_textView: UITextView) {
        contenuTextview.text=""
    }*/
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

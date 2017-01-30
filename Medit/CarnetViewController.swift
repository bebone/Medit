//
//  CarnetViewController.swift
//  Medit
//
//  Created by ANAIS VIDAL on 20/01/2017.
//  Copyright © 2017 ANAIS VIDAL. All rights reserved.
//

import UIKit

class CarnetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    
  /* INFO : renommage de Carnet en Journal de bord */

  var cellsFichier = [String]() //Création d'un tableau string vide pour manipulation
  var cellsUrlFichier = [URL]()
  var nombreCells:Int = 0
    
    @IBOutlet weak var carnetTableview: UITableView!
    
    @IBOutlet weak var contenuArticleTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title="Journal de bord"
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(CarnetViewController.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.5 //appuie plus de 0.5s
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.carnetTableview.addGestureRecognizer(lpgr)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carnetTableview.reloadData() // on rafraichit la liste
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // récupération des URL des fichiers txt stockés dans l'app
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            let txtFiles = directoryContents.filter{ $0.pathExtension == "txt" }
            print("txt urls:",txtFiles)
            cellsUrlFichier = txtFiles //on sauvegarde les urls (on l'affiche pas)
            
            let txtFileNames = txtFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("txt list:", txtFileNames)
            nombreCells = txtFileNames.count  //nombre de cellule dans la tableView
            cellsFichier=txtFileNames //Population du tableau créé précedemment
            
            //
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nombreCells

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        let cell = UITableViewCell(style:UITableViewCellStyle.default , reuseIdentifier: "cell")
      
        //Injection des valeurs du tableau dans les cellules
            cell.textLabel?.text = cellsFichier[indexPath.row]
        return(cell)
    }
    
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let row = indexPath.row
        //print(cellsUrlFichier[row]) //Debug
        let fileURL = cellsUrlFichier[row]
        var inString = ""
        do {
            inString = try String(contentsOf: fileURL)
        } catch {
            print("Impossible de lire l' URL: \(fileURL), Error: " + error.localizedDescription)
        }
        //print("Read from file: \(inString)") //Debug
        contenuArticleTextView.text = inString
    }
    
    func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: carnetTableview)
        let indexPath = carnetTableview.indexPathForRow(at: p)
        
        if let index = indexPath {
            _ = carnetTableview.cellForRow(at: index)
            let alertDelete = UIAlertController(title: "Supprimer", message: "Etes vous sûr de vouloir supprimer l'article "+cellsFichier[index.row]+"?", preferredStyle: UIAlertControllerStyle.alert)
            alertDelete.addAction(UIAlertAction(title: "Oui", style: .default, handler: { (action: UIAlertAction!) in
                print("Debug")
                self.deleteArticle(itemName: self.cellsFichier[index.row], fileExtension: "txt")
                
            }))
            alertDelete.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.default, handler: nil))
         
            self.present(alertDelete, animated: true, completion: nil)
            
        } else {
            print("Could not find index path")
        }
    }
    
 
    func deleteArticle(itemName:String, fileExtension: String) {
        //avec l'aide de http://stackoverflow.com/questions/15017902/delete-specified-file-from-document-directory#15018209
        
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
        do {
            try fileManager.removeItem(atPath: filePath)
            
            let alertDeleteSuccess = UIAlertController(title: "Supprimé !", message: "Article supprimé !", preferredStyle: UIAlertControllerStyle.alert)
            alertDeleteSuccess.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertDeleteSuccess, animated: true, completion: nil)
            contenuArticleTextView.text = "Choisissez un contenu dans la liste"
            viewWillAppear(true)


        } catch let error as NSError {
            print(error.debugDescription)
        }}
    


}
